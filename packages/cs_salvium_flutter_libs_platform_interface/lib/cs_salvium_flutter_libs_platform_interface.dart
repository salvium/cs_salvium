import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_cs_salvium_flutter_libs.dart';

abstract class CsSalviumFlutterLibsPlatform extends PlatformInterface {
  /// Constructs a CsMoneroFlutterLibsPlatformInterfacePlatform.
  CsSalviumFlutterLibsPlatform() : super(token: _token);

  static final Object _token = Object();

  static CsSalviumFlutterLibsPlatform _instance =
      MethodChannelCsMoneroFlutterLibs();

  /// The default instance of [CsSalviumFlutterLibsPlatform] to use.
  ///
  /// Defaults to [MethodChannelCsMoneroFlutterLibs].
  static CsSalviumFlutterLibsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsSalviumFlutterLibsPlatform] when
  /// they register themselves.
  static set instance(CsSalviumFlutterLibsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();
}
