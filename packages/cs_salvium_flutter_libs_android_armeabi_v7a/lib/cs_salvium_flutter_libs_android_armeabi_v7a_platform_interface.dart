import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cs_salvium_flutter_libs_android_armeabi_v7a_method_channel.dart';

abstract class CsSalviumFlutterLibsAndroidArmeabiV7aPlatform extends PlatformInterface {
  /// Constructs a CsMoneroFlutterLibsAndroidArmeabiV7aPlatform.
  CsSalviumFlutterLibsAndroidArmeabiV7aPlatform() : super(token: _token);

  static final Object _token = Object();

  static CsSalviumFlutterLibsAndroidArmeabiV7aPlatform _instance = MethodChannelCsMoneroFlutterLibsAndroidArmeabiV7a();

  /// The default instance of [CsSalviumFlutterLibsAndroidArmeabiV7aPlatform] to use.
  ///
  /// Defaults to [MethodChannelCsMoneroFlutterLibsAndroidArmeabiV7a].
  static CsSalviumFlutterLibsAndroidArmeabiV7aPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsSalviumFlutterLibsAndroidArmeabiV7aPlatform] when
  /// they register themselves.
  static set instance(CsSalviumFlutterLibsAndroidArmeabiV7aPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
