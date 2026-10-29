// huish/huish_about_page.dart —— 关于界面说明 + 免责声明。
// 参考原掌上华电的"关于"结构：版本信息 + 功能说明 + 免责声明。

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme.dart';
import '../../widgets/glass_background.dart';
import '../../widgets/glass_snackbar.dart';

/// 开源地址（与 GitHub 仓库保持一致）。
const String _kRepoUrl = 'https://github.com/changzheng7001/huish798-app';

/// 参考项目「掌上华电」的开源地址。
const String _kRefUrl = 'https://github.com/YechoY/Ncepu-Assistant';

class HuishAboutPage extends StatelessWidget {
  const HuishAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GlassBackground(child: const SizedBox.shrink()),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: kPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        '关于',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: kInk,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _sectionCard(
                  children: [
                    _sectionTitle('关于本应用'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '「喝在西皮」是一款以 Vibe Coding（AI 辅助协作编程）方式开发的'
                      '校园饮水服务客户端，对接正元智慧（ilife / CLOUDORA）一卡通平台的饮水设备接口。'
                      '支持扫码 / 手动添加设备、一键取水、消费记录查看与设备分组管理等能力。'
                      '本项目为开源学习项目，代码可在下方开源地址查看。',
                    ),
                    const SizedBox(height: 12),
                    _kv('版本', kHuishVersion),
                    _kv('包名', 'com.huish798.app'),
                    _kv('开发者', 'changzheng7001'),
                    _kv('数据接口', 'i.ilife798.com'),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('参考与开源'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '界面与交互参考自开源项目「掌上华电」（Ncepu-Assistant），'
                      '参考地址如下，点击可复制：',
                    ),
                    const SizedBox(height: 6),
                    _copyBlock(context, '参考项目', _kRefUrl),
                    const SizedBox(height: 14),
                    const _BodyText(
                      '如果你需要定制化版本，可参考本项目的开源源码（下方地址），'
                      '将需求发给 AI Agent，让它基于本项目为你修改。',
                    ),
                    const SizedBox(height: 6),
                    _copyBlock(context, '本项目源码', _kRepoUrl),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('免责声明'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '1. 本应用为个人 / 学习用途的第三方客户端，非官方产品，与'
                      '正元智慧及其下属公司、学校无任何关联，不代表官方立场。',
                    ),
                    const _BodyText(
                      '2. 应用通过公开接口协议与饮水服务交互，官方升级协议可能导致'
                      '部分功能暂时失效，请以官方 App 为准。',
                    ),
                    const _BodyText(
                      '3. 请合理使用本应用，不得用于任何商业用途或违反校规校纪的行为。'
                      '账号安全、充值消费等均以官方服务为准，因使用本应用产生的'
                      '任何损失由使用者自行承担。',
                    ),
                    const _BodyText(
                      '4. 应用会通过官方接口读取您的账户、账单与设备信息用于展示，'
                      '数据存储于本机，不会上传至任何第三方服务器。',
                    ),
                    const _BodyText(
                      '5. 如涉及相关权利问题，请通过官方渠道反馈，我们会配合处理。',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _sectionTitle(String s) => Text(
    s,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: kInk,
    ),
  );

  Widget _kv(String k, String v) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(k, style: const TextStyle(fontSize: 13, color: kTextMuted)),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(fontSize: 13, color: kTextMain),
          ),
        ),
      ],
    ),
  );

  /// 可点击复制链接的地址块。
  Widget _copyBlock(BuildContext context, String label, String url) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: url));
        if (context.mounted) {
          showGlassSnackBar(context, '已复制$label地址');
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: kPrimary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.link_rounded, size: 17, color: kPrimary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                url.replaceFirst('https://', ''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: kPrimary,
                ),
              ),
            ),
            Text(
              '复制',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: kPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          height: 1.6,
          color: kTextMain.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
