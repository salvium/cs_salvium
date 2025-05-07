import 'package:cs_monero_flutter_libs_platform_interface/cs_monero_flutter_libs_platform_interface.dart';

class CsMoneroFlutterLibs {
  Future<String?> getPlatformVersion() {
    return CsMoneroFlutterLibsPlatform.instance.getPlatformVersion();
  }
}
