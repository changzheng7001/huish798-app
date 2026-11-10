// huish_auth_state.dart —— 饮水模块登录状态（独立 Riverpod，与教务 auth_state 互不污染）。

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'huish_api_client.dart';

final huishApiClientProvider = Provider<HuishApiClient>((ref) {
  return HuishApiClient();
});

final huishAuthStateProvider =
    NotifierProvider<HuishAuthNotifier, HuishAuthState>(HuishAuthNotifier.new);

class HuishAuthState {
  final bool loggedIn;
  final String? phone;
  final String? uid;
  final String? eid;
  final String? token;
  final String? error;
  HuishAuthState({
    this.loggedIn = false,
    this.phone,
    this.uid,
    this.eid,
    this.token,
    this.error,
  });
  HuishAuthState copyWith({
    bool? loggedIn,
    String? phone,
    String? uid,
    String? eid,
    String? token,
    String? error,
    bool clearError = false,
  }) {
    return HuishAuthState(
      loggedIn: loggedIn ?? this.loggedIn,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
      eid: eid ?? this.eid,
      token: token ?? this.token,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class HuishAuthNotifier extends Notifier<HuishAuthState> {
  late final HuishApiClient _api;
  Future<void>? _restoreFuture;

  @override
  HuishAuthState build() {
    _api = ref.watch(huishApiClientProvider);
    _restoreFuture = _tryRestore();
    return HuishAuthState();
  }

  /// 等待启动时的 token 恢复完成（入口页须先 await 再判断 loggedIn，
  /// 否则恢复未完成时 loggedIn 恒为 false，会被误判为未登录）。
  Future<void> ensureRestored() => _restoreFuture ?? Future.value();

  Future<void> _tryRestore() async {
    final ok = await _api.restoreToken();
    if (ok && _api.token != null) {
      final phone = await _api.readSavedPhone();
      state = state.copyWith(
        loggedIn: true,
        phone: phone,
        uid: _api.uid,
        eid: _api.eid,
        token: _api.token,
      );
    }
  }

  Future<bool> login(String phone, String smsCode) async {
    state = state.copyWith(clearError: true);
    final resp = await _api.login(phone: phone, smsCode: smsCode);
    if (resp.isSuccess) {
      state = state.copyWith(
        loggedIn: true,
        phone: phone,
        uid: _api.uid,
        eid: _api.eid,
        token: _api.token,
      );
      return true;
    } else {
      // 服务端 msg 才是真正原因（如"短信验证码错误"），code 只是通用失败码
      state = state.copyWith(error: _describeLoginFailure(resp));
      return false;
    }
  }

  /// 用官方 App 已有的 token 登录（登录接口强制签名，仅凭证可复用）。
  Future<bool> loginWithToken(String token) async {
    state = state.copyWith(clearError: true);
    final resp = await _api.loginWithToken(token);
    if (resp.isSuccess) {
      final phone = await _api.readSavedPhone();
      state = state.copyWith(
        loggedIn: true,
        phone: phone,
        uid: _api.uid,
        eid: _api.eid,
        token: _api.token,
      );
      return true;
    }
    state = state.copyWith(error: _describeLoginFailure(resp));
    return false;
  }

  /// 把服务端的通用失败码翻译成用户能看懂的话。
  String _describeLoginFailure(HuishApiResponse resp) {
    final reason = resp.msg.trim();
    if (reason.contains('请升级') || reason.contains('验签')) {
      return '官方已限制第三方客户端登录（需官方签名），请改用「Token 登录」';
    }
    return reason.isNotEmpty
        ? '$reason（code: ${resp.code}）'
        : '登录失败（code: ${resp.code}）';
  }

  Future<void> logout() async {
    await _api.clearToken();
    state = HuishAuthState();
  }
}
