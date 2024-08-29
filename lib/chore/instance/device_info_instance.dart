import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoInstance {
  static final DeviceInfoInstance _instance = DeviceInfoInstance._internal();
  String _deviceType = "Unknown Device";

  factory DeviceInfoInstance() {
    return _instance;
  }

  DeviceInfoInstance._internal();

  Future<void> loadDeviceType() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      _deviceType = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      _deviceType = iosInfo.utsname.machine;
    }
  }

  String get deviceType => _deviceType;
}
