
import 'cs_salvium_flutter_libs_android_armeabi_v7a_platform_interface.dart';

class CsMoneroFlutterLibsAndroidArmeabiV7a {
  Future<String?> getPlatformVersion() {
    return CsSalviumFlutterLibsAndroidArmeabiV7aPlatform.instance.getPlatformVersion();
  }
}
