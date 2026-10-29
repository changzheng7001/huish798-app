// huish/nfc_service.dart —— NFC 一键启动饮水设备：预留通道。
//
// 目标：后期通过手机 NFC 贴一下设备感应区，即可识别对应设备并一键启动取水。
// 本文件是"通道骨架"：把「读卡 → 解析设备号 → 调用 startDevice」的完整链路
// 结构先立好，并通过 [kEnableNfc] 开关控制是否真正接入 NFC 硬件。
//
// 接入方式（后续做）：
//   在 pubspec.yaml 添加 nfc_manager 依赖，然后在 _nativeReadDeviceId()
//   里用 NfcManager 读取 NDEF / 标签 ID，映射到设备 did 后返回。
// 现在开关关闭时，UI 会提示"通道已预留"，不影响正常构建与使用。

/// 是否启用 NFC 读卡。false = 仅预留入口（UI 提示待接入）。
const bool kEnableNfc = false;

/// NFC 读取结果：解析出的设备号。
class HuishNfcReadResult {
  final String deviceId;
  const HuishNfcReadResult(this.deviceId);
}

class HuishNfcService {
  const HuishNfcService();

  /// 设备是否支持 NFC 硬件读取（当前未接入，恒定 false）。
  Future<bool> isSupported() async => kEnableNfc;

  /// 读取并解析 NFC 标签 → 设备号。
  /// 接入 nfc_manager 后在此实现真正的读卡与映射：
  ///   final tag = await NfcManager.instance.startSession(onDiscovered: ...);
  ///   final did = mapCardIdToDevice(tag.id);  // 由"设备列表 + 机身 NFC 标签"建立映射
  ///   return HuishNfcReadResult(did);
  Future<HuishNfcReadResult?> readDeviceId() async {
    if (!kEnableNfc) return null;
    return null;
  }
}
