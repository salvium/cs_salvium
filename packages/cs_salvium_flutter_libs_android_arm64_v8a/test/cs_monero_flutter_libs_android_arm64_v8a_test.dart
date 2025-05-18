import 'package:cs_salvium_flutter_libs_android_arm64_v8a/cs_salvium_flutter_libs_android_arm64_v8a.dart';
import 'package:cs_salvium_flutter_libs_android_arm64_v8a/cs_salvium_flutter_libs_android_arm64_v8a_method_channel.dart';
import 'package:cs_salvium_flutter_libs_android_arm64_v8a/cs_salvium_flutter_libs_android_arm64_v8a_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCsSalviumFlutterLibsAndroidArm64V8aPlatform
    with MockPlatformInterfaceMixin
    implements CsSalviumFlutterLibsAndroidArm64V8aPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CsSalviumFlutterLibsAndroidArm64V8aPlatform initialPlatform =
      CsSalviumFlutterLibsAndroidArm64V8aPlatform.instance;

  test(
      '$MethodChannelCsMoneroFlutterLibsAndroidArm64V8a is the default instance',
      () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelCsMoneroFlutterLibsAndroidArm64V8a>(),
    );
  });

  test('getPlatformVersion', () async {
    final csMoneroFlutterLibsAndroidArm64V8aPlugin =
        CsSalviumFlutterLibsAndroidArm64V8a();
    final fakePlatform = MockCsSalviumFlutterLibsAndroidArm64V8aPlatform();
    CsSalviumFlutterLibsAndroidArm64V8aPlatform.instance = fakePlatform;

    expect(
      await csMoneroFlutterLibsAndroidArm64V8aPlugin.getPlatformVersion(),
      '42',
    );
  });
}
