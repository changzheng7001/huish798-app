// huish/huish_disclaimer_page.dart —— 首次启动免责声明同意页。
// 符合《网络安全法》《个人信息保护法》等要求：初次使用必须阅读并同意
// 免责声明后方可使用 App；同意结果持久化，之后不再弹出。
// 关于页面中的免责声明卡片亦保留"我已阅读并同意上述免责声明"字样。

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme.dart';
import '../../widgets/glass_background.dart';

/// 免责声明同意状态的本地持久化存储。
class DisclaimerStore {
  static const String _key = 'disclaimer_agreed_v1';

  /// 是否已经同意过免责声明。
  static Future<bool> agreed() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_key) ?? false;
  }

  /// 记录用户已同意免责声明。
  static Future<void> agree() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_key, true);
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

  /// 用户同意后回调（由 _Gate 负责切换到正式页面）。
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
                        onTap: () {
                          // 先记录同意，再切换到正式页面。
                          DisclaimerStore.agree();
                          onAgreed();
                        },
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
