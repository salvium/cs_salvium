import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cs_monero_flutter_libs_android_armeabi_v7a_method_channel.dart';

abstract class CsMoneroFlutterLibsAndroidArmeabiV7aPlatform extends PlatformInterface {
  /// Constructs a CsMoneroFlutterLibsAndroidArmeabiV7aPlatform.
  CsMoneroFlutterLibsAndroidArmeabiV7aPlatform() : super(token: _token);

  static final Object _token = Object();

  static CsMoneroFlutterLibsAndroidArmeabiV7aPlatform _instance = MethodChannelCsMoneroFlutterLibsAndroidArmeabiV7a();

  /// The default instance of [CsMoneroFlutterLibsAndroidArmeabiV7aPlatform] to use.
  ///
  /// Defaults to [MethodChannelCsMoneroFlutterLibsAndroidArmeabiV7a].
  static CsMoneroFlutterLibsAndroidArmeabiV7aPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsMoneroFlutterLibsAndroidArmeabiV7aPlatform] when
  /// they register themselves.
  static set instance(CsMoneroFlutterLibsAndroidArmeabiV7aPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
