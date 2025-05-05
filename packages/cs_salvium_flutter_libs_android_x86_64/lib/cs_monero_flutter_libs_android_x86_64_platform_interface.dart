import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cs_monero_flutter_libs_android_x86_64_method_channel.dart';

abstract class CsSalviumFlutterLibsAndroidX8664Platform extends PlatformInterface {
  /// Constructs a CsSalviumFlutterLibsAndroidX8664Platform.
  CsSalviumFlutterLibsAndroidX8664Platform() : super(token: _token);

  static final Object _token = Object();

  static CsSalviumFlutterLibsAndroidX8664Platform _instance = MethodChannelCsSalviumFlutterLibsAndroidX8664();

  /// The default instance of [CsSalviumFlutterLibsAndroidX8664Platform] to use.
  ///
  /// Defaults to [MethodChannelCsSalviumFlutterLibsAndroidX8664].
  static CsSalviumFlutterLibsAndroidX8664Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsSalviumFlutterLibsAndroidX8664Platform] when
  /// they register themselves.
  static set instance(CsSalviumFlutterLibsAndroidX8664Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
