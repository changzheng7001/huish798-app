# 喝在西皮（huish798-app）

> 一款以**豆包（Doubao）AI（Vibe Coding，AI 辅助协作编程）**方式开发的校园饮水服务客户端。它把开源项目「掌上华电」的取水部分独立出来，重新设计了图标与色调，并尝试进一步液态玻璃化（效果一般，未完全成功），在消费记录中加入了跳转至相应设备的功能。应用对接**云哆啦科技有限公司**的 ilife / CLOUDORA 饮水设备接口，支持扫码 / 手动添加设备、一键取水、消费记录查看与设备分组管理等能力。

![platform](https://img.shields.io/badge/platform-Android-green) ![flutter](https://img.shields.io/badge/Flutter-3.x-blue)

---

## ✨ 功能特性

- **扫码 / 手动添加设备**：通过扫码或手动录入绑定饮水设备机位。
- **一键取水**：首页底部快捷入口，一键启动指定机位的取水操作。
- **消费记录查看**：账单按时间线展示，点击账单可跳回对应机位的操控界面。
- **设备分组管理**：按宿舍楼 / 楼层对设备进行分组与快捷筛选。
- **水蓝玻璃化 UI**：在掌上华电基础上重构了图标与色调，尝试对齐液态玻璃设计（效果一般，未完全成功），背景延伸至状态栏与底部导航栏。
- **NFC 预留通道**：预留了通过手机 NFC 一键启动对应饮水设备的能力（未接入，见「未达成功能」）。

## 📱 界面预览

> 应用界面截图（桌面图标、首页、设备页、账单页、关于页）待补充。

## 🛠 技术栈

- **语言 / 框架**：Dart · Flutter
- **状态管理**：Riverpod（`flutter_riverpod`）
- **网络请求**：`http`
- **扫码**：`mobile_scanner`
- **本地存储**：`shared_preferences` + `flutter_secure_storage`
- **加解密**：`crypto`

## 📂 项目结构

```
lib/
├── main.dart                  # 入口
├── app.dart                   # 根组件 + 启动路由
├── theme.dart                 # 主题色 / 版本号常量
├── widgets/
│   ├── glass_background.dart  # 玻璃渐变背景
│   └── glass_snackbar.dart    # 玻璃风 Snackbar
└── huish/
    ├── huish_api_client.dart  # API 客户端（i.ilife798.com）
    ├── huish_login_page.dart  # 登录页
    ├── huish_home_page.dart   # 首页（设备列表 + 一键取水）
    ├── huish_device_page.dart # 机位操控页
    ├── huish_bill_page.dart   # 消费记录 / 账单页
    ├── huish_about_page.dart  # 关于 + 免责声明
    └── nfc_service.dart       # NFC 预留通道
android/
└── app/src/main/
    ├── AndroidManifest.xml    # 应用名「喝在西皮」
    └── res/values/styles.xml  # 透明系统栏（背景延伸）
```

## 🔧 环境要求与构建

- Flutter 3.x（需配置 Android SDK）
- 构建单架构 release APK：

```bash
export ANDROID_HOME=/path/to/android-sdk
export JAVA_HOME=/path/to/jdk-17
export PATH="$JAVA_HOME/bin:$PATH"
flutter build apk --release --target-platform android-arm64
```

产物位于 `build/app/outputs/flutter-apk/app-release.apk`。

## 🔐 登录与数据接口说明

- 应用的饮水服务由**云哆啦科技有限公司**提供，数据接口为 `i.ilife798.com`。
- 应用通过公开接口协议与饮水服务交互。
- 登录后账户、账单、设备信息仅存储在本地，不会上传至任何第三方服务器。

## 📖 参考项目

- **掌上华电（Ncepu-Assistant）**：界面与交互参考自该开源项目，向原作者致敬。
  GitHub: [github.com/YechoY/Ncepu-Assistant](https://github.com/YechoY/Ncepu-Assistant)
- **源头项目 huish**：取水逻辑的源头参考。因存在版本号 bug（硬编码 3.1.4，被服务端版本门禁拒绝）无法直接使用。
  GitHub: [github.com/KazemiyaMione/huish](https://github.com/KazemiyaMione/huish)

## 📜 开发历程

本项目以 **豆包（Doubao）AI（Vibe Coding，AI 辅助协作编程）** 方式完成：由人提出需求、AI 负责实现与打磨，形成"需求 → 生成 → 真机验证 → 修正"的闭环。每一轮都是一个完整版本的构建与交付，APK 均经真机安装验收。

> **时间说明**：本项目的开发**并非持续进行**，而是跨多轮会话分段完成。若折算成持续开发，累计工作量约为 **4 小时左右**；其中约 **2 小时多**用于**第一次生成 App**（搭建 Flutter 工程、接入取水接口、产出首个可用版本）。首次生成时云端沙箱状况不佳（构建反复卡顿、Flutter daemon 在沙箱残留引发锁冲突、后台任务易被中断），导致首个版本未能一次构建成功，**新建对话后才成功构建出第一个可用版本**。

### 关键时间节点

| 时间 | 节点 |
|------|------|
| 2026-10-28 | 分析官方「慧生活798」APK，梳理饮水模块结构，随后启动改造 |
| 2026-10-28 | 首次生成 App（约 2 小时多；云端状况不佳，新建对话后成功构建首个版本） |
| 2026-10-28 ~ 10-29 | 逐项改造：图标去白圈、顶部玻璃条、一键取水、背景上下延伸、消费记录跳转机位 |
| 2026-10-29 | 对比 huish / 798 / Ncepu 三仓库接口，定位版本门禁问题（源头 huish 因版本号 bug 无法使用） |
| 2026-10-30 | 定位「当前设备正在使用」（-15）状态判定脱节问题；完成更名「喝在西皮」与开源发布 |

## 🚧 未达成功能

1. **反复取水后设备无法启动**：同一设备反复点击「开始取水」太多次后，会提示「当前设备正在使用」（-15）而无法启动。根因是客户端与服务端对设备状态的判定脱节（客户端显示"空闲"，服务端仍有独立占用判定）。已定位，修复方向（启动前先查状态、`stop` 补 `rcp=false`、`start` 补 `cnt=1`、错误码表补 `-15`）尚未实施。
2. **NFC 一键启动饮水设备**：已预留 NFC 服务通道，但尚未接入手机 NFC 一键启动对应设备的能力。

## ⚠️ 免责声明

1. 本项目为**个人 / 学习用途的第三方客户端**，非官方产品，与云哆啦科技有限公司及其关联方、学校无任何关联，不代表官方立场。
2. 应用通过公开接口协议与饮水服务交互，官方升级协议可能导致部分功能暂时失效，请以官方 App 为准。
3. 请合理使用本应用，不得用于任何商业用途或违反校规校纪的行为。账号安全、充值消费等均以官方服务为准，因使用本应用产生的任何损失由使用者自行承担。
4. 如涉及相关权利问题，请通过开源仓库 Issues 反馈，我们会配合处理。

## 📄 开源协议

本项目以 **MIT License** 开源，详情见 [LICENSE](./LICENSE)。

## 👤 开发者

- GitHub: [changzheng7001](https://github.com/changzheng7001)
- 仓库地址：[changzheng7001/huish798-app](https://github.com/changzheng7001/huish798-app)

> 项目仅供学习交流使用，若对你有帮助，欢迎 Star ⭐
