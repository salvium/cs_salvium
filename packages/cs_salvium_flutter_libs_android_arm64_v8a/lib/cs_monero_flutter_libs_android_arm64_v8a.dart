
import 'cs_monero_flutter_libs_android_arm64_v8a_platform_interface.dart';

class CsSalviumFlutterLibsAndroidArm64V8a {
  Future<String?> getPlatformVersion() {
    return CsSalviumFlutterLibsAndroidArm64V8aPlatform.instance.getPlatformVersion();
  }
}
