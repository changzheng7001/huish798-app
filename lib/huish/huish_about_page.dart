// huish/huish_about_page.dart —— 关于界面说明 + 免责声明。
// 参考原掌上华电的"关于"结构：版本信息 + 功能说明 + 免责声明。

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme.dart';
import '../../widgets/glass_background.dart';
import '../../widgets/glass_snackbar.dart';

/// 本项目开源地址（与 GitHub 仓库保持一致）。
const String _kRepoUrl = 'https://github.com/changzheng7001/huish798-app';

/// 参考项目「掌上华电」的开源地址。
const String _kRefUrl = 'https://github.com/YechoY/Ncepu-Assistant';

/// 源头项目「huish」的开源地址（存在版本号 bug，无法直接使用）。
const String _kHuishUrl = 'https://github.com/KazemiyaMione/huish';

/// 源头项目的社区修复版「798v6.0.0」。
const String _kFixUrl = 'https://github.com/QYNU11/798v6.0.0';

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
                      '「喝在西皮」是一款以豆包（Doubao）AI（Vibe Coding，AI 辅助协作编程）'
                      '方式开发的校园饮水服务客户端。它将开源项目「掌上华电」的取水部分'
                      '独立出来，重新设计了应用图标与色调，并尝试进一步液态玻璃化'
                      '（效果一般，未完全成功）；同时在消费记录中加入了跳转至相应设备的功能。'
                      '应用对接云哆啦科技有限公司的 ilife / CLOUDORA 饮水设备接口。'
                      '这也是作者第一次以 Vibe Coding 方式开发 Flutter 项目（此前仅用'
                      '豆包做过网页套壳的教务查询 App），整体更偏学习与尝试性质。',
                    ),
                    const SizedBox(height: 12),
                    _kv('版本', kHuishVersion),
                    _kv('包名', 'com.huish798.app'),
                    _kv('开发者', 'changzheng7001'),
                    _kv('服务提供方', '云哆啦科技'),
                    _kv('数据接口', 'i.ilife798.com'),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('参考与开源'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '界面与交互参考自开源项目「掌上华电」（Ncepu-Assistant）：',
                    ),
                    const SizedBox(height: 6),
                    _openLink(context, '掌上华电', _kRefUrl),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '本项目亦参考了源头项目「huish」（因版本号 bug 无法直接使用）：',
                    ),
                    const SizedBox(height: 6),
                    _openLink(context, '源头项目', _kHuishUrl),
                    const SizedBox(height: 12),
                    const _BodyText(
                      '本项目源码已开源，仅供学习交流。如果你也想打造类似的饮水服务客户端，'
                      '可以参考这份源码，并结合 AI 辅助编程工具，按自己的需求进行调整：',
                    ),
                    const SizedBox(height: 6),
                    _openLink(context, '本项目源码', _kRepoUrl),
                    const SizedBox(height: 12),
                    const _BodyText(
                      '当然了，由于本项目完全是豆包生成的，再加上作者几乎没有编程基础'
                      '与相关知识，如果你不信任豆包生成的代码，大可以绕过这个'
                      '「屎山代码」，直接从上层开源方案入手修改——差别应该不会太大。'
                      '去尝试 Vibe Coding，去定制属于自己的功能吧！😄',
                    ),
                    const SizedBox(height: 10),
                    const _BodyText('也可以直接参考这些开源方案：'),
                    const SizedBox(height: 6),
                    _openLink(context, '修复版 798v6.0.0', _kFixUrl),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('待完善功能'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '1. 反复点击取水后，部分设备会提示「当前设备正在使用」而无法启动'
                      '（客户端与服务端状态判定脱节，已定位、暂未修复）。',
                    ),
                    const _BodyText(
                      '2. 通过手机 NFC 一键启动对应饮水设备（已预留通道，暂未接入）。',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('致谢'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '特别感谢「掌上华电」（Ncepu-Assistant）项目：界面清爽、操作逻辑'
                      '方便，解决了作者一直想解决的问题，本应用界面与交互以其为参考。',
                    ),
                    const _BodyText(
                      '同时感谢源头项目「huish798」（取水逻辑参考）及其社区修复版'
                      '「798v6.0.0」。',
                    ),
                    const _BodyText(
                      '应用名称「喝在西皮」由室长 Tianze 提供，应用图标由 ChatGPT 生成，'
                      '特此致谢。',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('关于刷积分'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '本应用不会加入刷积分相关功能：能够去除广告、便捷取水，已经足够；'
                      '刷积分会加大对官方利益的侵害，故不内置。',
                    ),
                    const _BodyText(
                      '不过作为 Vibe Coding 学习项目，这也是一个可探索的方向——如果你'
                      '感兴趣，可自行尝试实现（参考 huish798 等项目），请在合法合规的'
                      '前提下探索。',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _sectionCard(
                  children: [
                    _sectionTitle('免责声明'),
                    const SizedBox(height: 10),
                    const _BodyText(
                      '1. 本应用为个人 / 学习用途的第三方客户端，非官方产品，与'
                      '云哆啦科技有限公司及其关联方、学校无任何关联，不代表官方立场。',
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
          width: 68,
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

  /// 点击直接跳转到对应页面的地址块。
  Widget _openLink(BuildContext context, String label, String url) {
    return GestureDetector(
      onTap: () => _launch(context, url),
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
              label,
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

  Future<void> _launch(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      showGlassSnackBar(context, '无法打开链接，请检查网络');
    }
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
