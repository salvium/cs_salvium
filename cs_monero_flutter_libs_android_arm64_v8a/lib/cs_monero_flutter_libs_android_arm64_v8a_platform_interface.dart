import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cs_monero_flutter_libs_android_arm64_v8a_method_channel.dart';

abstract class CsMoneroFlutterLibsAndroidArm64V8aPlatform extends PlatformInterface {
  /// Constructs a CsMoneroFlutterLibsAndroidArm64V8aPlatform.
  CsMoneroFlutterLibsAndroidArm64V8aPlatform() : super(token: _token);

  static final Object _token = Object();

  static CsMoneroFlutterLibsAndroidArm64V8aPlatform _instance = MethodChannelCsMoneroFlutterLibsAndroidArm64V8a();

  /// The default instance of [CsMoneroFlutterLibsAndroidArm64V8aPlatform] to use.
  ///
  /// Defaults to [MethodChannelCsMoneroFlutterLibsAndroidArm64V8a].
  static CsMoneroFlutterLibsAndroidArm64V8aPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsMoneroFlutterLibsAndroidArm64V8aPlatform] when
  /// they register themselves.
  static set instance(CsMoneroFlutterLibsAndroidArm64V8aPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
