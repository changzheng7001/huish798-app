// app.dart —— 独立「惠生活798·饮水」根组件 + 启动路由。
//
// 原掌上华电是一个「模块导航页 → 学习服务 / 生活服务」的结构；独立出来后
// 不再有模块导航，直接以登录态为准：启动恢复 token 后，
//   未登录 → HuishLoginPage
//   已登录 → HuishHomePage

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import 'widgets/glass_background.dart';
import 'huish/huish_auth_state.dart';
import 'huish/huish_disclaimer_page.dart';
import 'huish/huish_home_page.dart';
import 'huish/huish_login_page.dart';

/// 根组件：MaterialApp + 启动门卫。
class HuishApp extends StatelessWidget {
  const HuishApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: '喝在西皮',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        locale: const Locale('zh', 'CN'),
        supportedLocales: const [Locale('zh', 'CN'), Locale('en')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const _Gate(),
      );
}

/// 启动门卫：恢复登录态后再决定进登录页还是主页。
/// 必须等 ensureRestored() 完成，否则恢复未结束时 loggedIn 恒为 false，
/// 已登录用户会被误判为未登录。
class _Gate extends ConsumerStatefulWidget {
  const _Gate();

  @override
  ConsumerState<_Gate> createState() => _GateState();
}

class _GateState extends ConsumerState<_Gate> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 恢复本地保存的 token；完成后 setState 进入正式路由判定。
      await ref.read(huishAuthStateProvider.notifier).ensureRestored();
      // 读取免责声明同意状态（首次使用需先同意；关于页可反悔为不同意）。
      final ok = await DisclaimerStore.agreed();
      ref.read(disclaimerStateProvider.notifier).state =
          ok ? DisclaimerState.agreed : DisclaimerState.pending;
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // watch 监听登录态：登录/退出后自动在登录页与主页之间切换。
    final auth = ref.watch(huishAuthStateProvider);
    // 免责声明三态：agreed 可用；pending 首次同意页；disagreed 不可用占位页。
    final disclaimer = ref.watch(disclaimerStateProvider);

    if (!_ready) {
      // 恢复中：显示玻璃拟态背景的加载转圈。
      return const Scaffold(
        body: GlassBackground(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // 明确不同意：不退出 App，但应用不可用（仅提供重新同意入口）。
    if (disclaimer == DisclaimerState.disagreed) {
      return HuishDisclaimerBlockedPage(
        onReAgree: () async {
          // 先带用户回到完整免责声明正文，确实读过并在那里点「同意」才恢复可用；
          // 不能在这一页点一下就直接放行。
          final read = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (ctx) => HuishDisclaimerPage(
                onAgreed: () => Navigator.of(ctx).pop(true),
              ),
            ),
          );
          if (read != true) return;
          await DisclaimerStore.agree();
          ref.read(disclaimerStateProvider.notifier).state =
              DisclaimerState.agreed;
        },
      );
    }

    // 首次使用 / 未表态：先同意免责声明，方可进入 App。
    if (disclaimer != DisclaimerState.agreed) {
      return HuishDisclaimerPage(
        onAgreed: () {
          DisclaimerStore.agree();
          ref
              .read(disclaimerStateProvider.notifier)
              .state = DisclaimerState.agreed;
        },
      );
    }

    return auth.loggedIn ? const HuishHomePage() : const HuishLoginPage();
  }
}
