// main.dart —— 独立「惠生活798·饮水」App 入口。
// 从掌上华电(Ncepu-Assistant)的 huish 生活服务模块独立而来，保留玻璃拟态 UI。
//
// 仅需初始化调试日志器（SharedPreferences），无教务 SQLite 缓存，
// 所以比原工程精简：不再打开 CacheService、不再依赖 path_provider/sqflite。

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/debug_log.dart';

Future<void> main() async {
  // 只要在 runApp 前调用异步代码，就必须先初始化 Flutter 引擎绑定。
  WidgetsFlutterBinding.ensureInitialized();

  // 调试日志器初始化：必须在 Provider 创建之前调用，
  // 否则 LoggingHttpClient 首次构造时看不到 enabled 状态。
  await AppDebugLog.instance.init();

  // 对齐原掌上华电：edge-to-edge + 透明状态栏/导航栏，让玻璃背景上下延伸。
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 浅色背景用深色图标
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  runApp(
    // ProviderScope 是 Riverpod 根容器，所有 Provider 都要被它包裹。
    const ProviderScope(child: HuishApp()),
  );
}
