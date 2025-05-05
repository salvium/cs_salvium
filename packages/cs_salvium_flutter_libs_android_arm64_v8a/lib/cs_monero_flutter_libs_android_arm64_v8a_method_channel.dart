import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cs_monero_flutter_libs_android_arm64_v8a_platform_interface.dart';

/// An implementation of [CsSalviumFlutterLibsAndroidArm64V8aPlatform] that uses method channels.
class MethodChannelCsSalviumFlutterLibsAndroidArm64V8a extends CsSalviumFlutterLibsAndroidArm64V8aPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cs_monero_flutter_libs_android_arm64_v8a');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
