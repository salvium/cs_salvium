import 'package:cs_monero_flutter_libs_platform_interface/cs_monero_flutter_libs_platform_interface.dart';

class CsSalviumFlutterLibs {
  Future<String?> getPlatformVersion() {
    return CsSalviumFlutterLibsPlatform.instance.getPlatformVersion();
  }
}
