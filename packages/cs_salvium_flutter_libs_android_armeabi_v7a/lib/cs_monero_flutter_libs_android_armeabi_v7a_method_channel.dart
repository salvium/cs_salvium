import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cs_monero_flutter_libs_android_armeabi_v7a_platform_interface.dart';

/// An implementation of [CsSalviumFlutterLibsAndroidArmeabiV7aPlatform] that uses method channels.
class MethodChannelCsSalviumFlutterLibsAndroidArmeabiV7a extends CsSalviumFlutterLibsAndroidArmeabiV7aPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cs_monero_flutter_libs_android_armeabi_v7a');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
