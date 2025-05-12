import 'package:flutter/services.dart';

import 'cs_salvium_flutter_libs_platform_interface.dart';

const _channel = MethodChannel('cs_monero_flutter_libs');

class MethodChannelCsMoneroFlutterLibs extends CsMoneroFlutterLibsPlatform {
  @override
  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
