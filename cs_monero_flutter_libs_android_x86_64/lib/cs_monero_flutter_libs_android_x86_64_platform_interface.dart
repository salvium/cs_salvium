import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cs_monero_flutter_libs_android_x86_64_method_channel.dart';

abstract class CsMoneroFlutterLibsAndroidX8664Platform extends PlatformInterface {
  /// Constructs a CsMoneroFlutterLibsAndroidX8664Platform.
  CsMoneroFlutterLibsAndroidX8664Platform() : super(token: _token);

  static final Object _token = Object();

  static CsMoneroFlutterLibsAndroidX8664Platform _instance = MethodChannelCsMoneroFlutterLibsAndroidX8664();

  /// The default instance of [CsMoneroFlutterLibsAndroidX8664Platform] to use.
  ///
  /// Defaults to [MethodChannelCsMoneroFlutterLibsAndroidX8664].
  static CsMoneroFlutterLibsAndroidX8664Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsMoneroFlutterLibsAndroidX8664Platform] when
  /// they register themselves.
  static set instance(CsMoneroFlutterLibsAndroidX8664Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
