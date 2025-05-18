import 'package:cs_salvium_flutter_libs_android_arm64_v8a/cs_salvium_flutter_libs_android_arm64_v8a.dart';
import 'package:cs_salvium_flutter_libs_android_armeabi_v7a/cs_salvium_flutter_libs_android_armeabi_v7a.dart';
import 'package:cs_salvium_flutter_libs_android_x86_64/cs_salvium_flutter_libs_android_x86_64.dart';
import 'package:cs_salvium_flutter_libs_platform_interface/cs_salvium_flutter_libs_platform_interface.dart';
import 'package:flutter/services.dart';

const _channel = MethodChannel('cs_salvium_flutter_libs_android');

class CsSalviumFlutterLibsAndroid extends CsSalviumFlutterLibsPlatform {
  /// Registers this class as the default instance of [CsSalviumFlutterLibsPlatform].
  static void registerWith() {
    CsSalviumFlutterLibsPlatform.instance = CsSalviumFlutterLibsAndroid();
  }

  @override
  Future<String?> getPlatformVersion({
    bool overrideForBasicTestCoverageTesting = false,
  }) async {
    if (!overrideForBasicTestCoverageTesting) {
      // make calls so flutter doesn't tree shake
      await Future.wait([
        CsSalviumFlutterLibsAndroidArm64V8a().getPlatformVersion(),
        CsSalviumFlutterLibsAndroidArmeabiV7a().getPlatformVersion(),
        CsSalviumFlutterLibsAndroidX8664().getPlatformVersion(),
      ]);
    }

    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
