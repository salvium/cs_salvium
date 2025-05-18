import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cs_salvium_flutter_libs_android_arm64_v8a_method_channel.dart';

abstract class CsSalviumFlutterLibsAndroidArm64V8aPlatform extends PlatformInterface {
  /// Constructs a CsSalviumFlutterLibsAndroidArm64V8aPlatform.
  CsSalviumFlutterLibsAndroidArm64V8aPlatform() : super(token: _token);

  static final Object _token = Object();

  static CsSalviumFlutterLibsAndroidArm64V8aPlatform _instance = MethodChannelCsSalviumFlutterLibsAndroidArm64V8a();

  /// The default instance of [CsSalviumFlutterLibsAndroidArm64V8aPlatform] to use.
  ///
  /// Defaults to [MethodChannelCsSalviumFlutterLibsAndroidArm64V8a].
  static CsSalviumFlutterLibsAndroidArm64V8aPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsSalviumFlutterLibsAndroidArm64V8aPlatform] when
  /// they register themselves.
  static set instance(CsSalviumFlutterLibsAndroidArm64V8aPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
