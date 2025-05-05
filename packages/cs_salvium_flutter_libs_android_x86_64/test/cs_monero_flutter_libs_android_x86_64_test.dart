import 'package:cs_monero_flutter_libs_android_x86_64/cs_monero_flutter_libs_android_x86_64.dart';
import 'package:cs_monero_flutter_libs_android_x86_64/cs_monero_flutter_libs_android_x86_64_method_channel.dart';
import 'package:cs_monero_flutter_libs_android_x86_64/cs_monero_flutter_libs_android_x86_64_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCsSalviumFlutterLibsAndroidX8664Platform
    with MockPlatformInterfaceMixin
    implements CsSalviumFlutterLibsAndroidX8664Platform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CsSalviumFlutterLibsAndroidX8664Platform initialPlatform =
      CsSalviumFlutterLibsAndroidX8664Platform.instance;

  test('$MethodChannelCsSalviumFlutterLibsAndroidX8664 is the default instance',
      () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelCsSalviumFlutterLibsAndroidX8664>(),
    );
  });

  test('getPlatformVersion', () async {
    final CsSalviumFlutterLibsAndroidX8664Plugin =
        CsSalviumFlutterLibsAndroidX8664();
    final fakePlatform = MockCsSalviumFlutterLibsAndroidX8664Platform();
    CsSalviumFlutterLibsAndroidX8664Platform.instance = fakePlatform;

    expect(
      await CsSalviumFlutterLibsAndroidX8664Plugin.getPlatformVersion(),
      '42',
    );
  });
}
