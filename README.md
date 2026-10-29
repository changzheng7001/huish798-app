# 喝在西皮（huish798-app）

> 一款独立开发的校园饮水服务客户端。对接正元智慧（ilife / CLOUDORA）一卡通平台的饮水设备接口，支持扫码 / 手动添加设备、一键取水、消费记录查看与设备分组管理等能力。

![platform](https://img.shields.io/badge/platform-Android-green) ![flutter](https://img.shields.io/badge/Flutter-3.x-blue)

---

## ✨ 功能特性

- **扫码 / 手动添加设备**：通过扫码或手动录入绑定饮水设备机位。
- **一键取水**：首页底部快捷入口，一键启动指定机位的取水操作。
- **消费记录查看**：账单按时间线展示，点击账单可跳回对应机位的操控界面。
- **设备分组管理**：按宿舍楼 / 楼层对设备进行分组与快捷筛选。
- **液态玻璃 UI**：对齐 iOS 液态玻璃（Liquid Glass）设计语言的清爽水蓝界面，背景延伸至状态栏与底部导航栏。
- **NFC 预留通道**：预留了通过手机 NFC 一键启动对应饮水设备的能力（后续接入）。

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

- 应用通过公开接口协议与饮水服务交互，数据接口为 `i.ilife798.com`。
- 登录后账户、账单、设备信息仅存储在本地，不会上传至任何第三方服务器。

## 📖 参考项目

- **掌上华电（Ncepu-Assistant）**：界面与交互参考自该开源项目，向原作者致敬。
  GitHub: [github.com/YechoY/Ncepu-Assistant](https://github.com/YechoY/Ncepu-Assistant)

## ⚠️ 免责声明

1. 本项目为**个人 / 学习用途的第三方客户端**，非官方产品，与正元智慧及其下属公司、学校无任何关联，不代表官方立场。
2. 应用通过公开接口协议与饮水服务交互，官方升级协议可能导致部分功能暂时失效，请以官方 App 为准。
3. 请合理使用本应用，不得用于任何商业用途或违反校规校纪的行为。账号安全、充值消费等均以官方服务为准，因使用本应用产生的任何损失由使用者自行承担。
4. 如涉及相关权利问题，请通过开源仓库 Issues 反馈，我们会配合处理。

## 📄 开源协议

本项目以 **MIT License** 开源，详情见 [LICENSE](./LICENSE)。

## 👤 开发者

- GitHub: [changzheng7001](https://github.com/changzheng7001)
- 仓库地址：[changzheng7001/huish798-app](https://github.com/changzheng7001/huish798-app)

> 项目仅供学习交流使用，若对你有帮助，欢迎 Star ⭐
