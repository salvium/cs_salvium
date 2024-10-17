import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cs_monero_flutter_libs_platform_interface.dart';

/// An implementation of [CsMoneroFlutterLibsPlatform] that uses method channels.
class MethodChannelCsMoneroFlutterLibs extends CsMoneroFlutterLibsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cs_monero_flutter_libs');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
