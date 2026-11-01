// huish/huish_disclaimer_page.dart —— 免责声明模块。
// 符合《网络安全法》《个人信息保护法》等要求：初次使用必须阅读并同意
// 免责声明后方可使用 App；同意结果持久化，之后不再弹出。
// 关于页面中的免责声明卡片亦保留同意/不同意选择（不同意不退出 App，
// 但应用不可用）。
// 首次启动页「不同意并退出」直接退出 App；关于页「不同意」则停留在
// App 内但进入不可用状态（由 _Gate 的门卫控制）。

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme.dart';
import '../../widgets/glass_background.dart';

/// 免责声明全局状态：agreed=已同意可用；pending=未表态（首次显示同意页）；
/// disagreed=明确不同意（应用不可用，但不退出）。
enum DisclaimerState { pending, agreed, disagreed }

/// 免责声明状态 Provider：关于页「同意 / 不同意」与启动门卫共享同一状态。
final disclaimerStateProvider = StateProvider<DisclaimerState>(
  (ref) => DisclaimerState.pending,
);

/// 免责声明同意状态的本地持久化存储。
class DisclaimerStore {
  static const String _kAgreed = 'disclaimer_agreed_v1';
  static const String _kDisagreed = 'disclaimer_disagreed_v1';

  /// 是否处于"已同意且未反悔"状态。
  static Future<bool> agreed() async {
    final sp = await SharedPreferences.getInstance();
    return (sp.getBool(_kAgreed) ?? false) &&
        !(sp.getBool(_kDisagreed) ?? false);
  }

  /// 记录用户已同意免责声明。
  static Future<void> agree() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_kAgreed, true);
    await sp.remove(_kDisagreed);
  }

  /// 记录用户明确不同意（清除同意标记，App 将不可用但不退出）。
  static Future<void> disagree() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_kDisagreed, true);
    await sp.remove(_kAgreed);
  }
}

/// 免责声明正文（与 README「免责声明」章节保持一致）。
const List<String> kDisclaimerItems = [
  '本应用为个人 / 学习用途的第三方客户端，非官方产品，与云哆啦科技有限公司及其关联方、学校无任何关联，不代表官方立场。',
  '应用通过公开接口协议与饮水服务交互，官方升级协议可能导致部分功能暂时失效，请以官方 App 为准。',
  '请合理使用本应用，不得用于任何商业用途或违反校规校纪的行为。账号安全、充值消费等均以官方服务为准，因使用本应用产生的任何损失由使用者自行承担。',
  '应用会通过官方接口读取您的账户、账单与设备信息用于展示，数据存储于本机，不会上传至任何第三方服务器。',
  '如涉及相关权利问题，请通过开源仓库 Issues 反馈，我们会配合处理。',
];

/// 首次启动免责声明页：点击「我已阅读并同意上述免责声明」后进入 App。
class HuishDisclaimerPage extends StatelessWidget {
  const HuishDisclaimerPage({super.key, required this.onAgreed});

  /// 用户同意后回调（由 _Gate 负责写存储并切换到正式页面）。
  final VoidCallback onAgreed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GlassBackground(child: const SizedBox.shrink()),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 28),
                const Text(
                  '欢迎使用「喝在西皮」',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '使用前请阅读并同意以下免责声明',
                  style: TextStyle(
                    fontSize: 13,
                    color: kInk.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.62),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '免责声明',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: kInk,
                              ),
                            ),
                            const SizedBox(height: 10),
                            for (final item in kDisclaimerItems)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.55,
                                    color: kInk,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: onAgreed,
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: const Text(
                            '我已阅读并同意上述免责声明',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => SystemNavigator.pop(),
                        child: Text(
                          '不同意并退出',
                          style: TextStyle(
                            fontSize: 13,
                            color: kInk.withValues(alpha: 0.55),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 未同意免责声明时的"不可用"占位页：不退出 App，但应用无法使用，
/// 仅提供「重新阅读并同意」入口。
class HuishDisclaimerBlockedPage extends StatelessWidget {
  const HuishDisclaimerBlockedPage({super.key, required this.onReAgree});

  final VoidCallback onReAgree;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GlassBackground(child: const SizedBox.shrink()),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.gavel_rounded,
                    size: 56,
                    color: Color(0xFFB85450),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    '未同意免责声明',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: kInk,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '您已在关于页面选择「不同意」，为符合相关要求，'
                    '本应用暂不可用。\n如需继续使用，请重新阅读并同意免责声明。',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.6,
                      color: kTextMuted,
                    ),
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: onReAgree,
                    child: Container(
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Text(
                        '重新阅读并同意免责声明',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
