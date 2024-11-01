
import 'cs_monero_flutter_libs_android_armeabi_v7a_platform_interface.dart';

class CsMoneroFlutterLibsAndroidArmeabiV7a {
  Future<String?> getPlatformVersion() {
    return CsMoneroFlutterLibsAndroidArmeabiV7aPlatform.instance.getPlatformVersion();
  }
}
