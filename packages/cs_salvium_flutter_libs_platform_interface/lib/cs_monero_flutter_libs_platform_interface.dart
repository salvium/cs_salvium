import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_cs_monero_flutter_libs.dart';

abstract class CsMoneroFlutterLibsPlatform extends PlatformInterface {
  /// Constructs a CsMoneroFlutterLibsPlatformInterfacePlatform.
  CsMoneroFlutterLibsPlatform() : super(token: _token);

  static final Object _token = Object();

  static CsMoneroFlutterLibsPlatform _instance =
      MethodChannelCsMoneroFlutterLibs();

  /// The default instance of [CsMoneroFlutterLibsPlatform] to use.
  ///
  /// Defaults to [MethodChannelCsMoneroFlutterLibs].
  static CsMoneroFlutterLibsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsMoneroFlutterLibsPlatform] when
  /// they register themselves.
  static set instance(CsMoneroFlutterLibsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();
}
