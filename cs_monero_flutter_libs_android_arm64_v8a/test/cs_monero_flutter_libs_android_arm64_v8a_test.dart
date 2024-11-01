import 'package:flutter_test/flutter_test.dart';
import 'package:cs_monero_flutter_libs_android_arm64_v8a/cs_monero_flutter_libs_android_arm64_v8a.dart';
import 'package:cs_monero_flutter_libs_android_arm64_v8a/cs_monero_flutter_libs_android_arm64_v8a_platform_interface.dart';
import 'package:cs_monero_flutter_libs_android_arm64_v8a/cs_monero_flutter_libs_android_arm64_v8a_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCsMoneroFlutterLibsAndroidArm64V8aPlatform
    with MockPlatformInterfaceMixin
    implements CsMoneroFlutterLibsAndroidArm64V8aPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CsMoneroFlutterLibsAndroidArm64V8aPlatform initialPlatform = CsMoneroFlutterLibsAndroidArm64V8aPlatform.instance;

  test('$MethodChannelCsMoneroFlutterLibsAndroidArm64V8a is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibsAndroidArm64V8a>());
  });

  test('getPlatformVersion', () async {
    CsMoneroFlutterLibsAndroidArm64V8a csMoneroFlutterLibsAndroidArm64V8aPlugin = CsMoneroFlutterLibsAndroidArm64V8a();
    MockCsMoneroFlutterLibsAndroidArm64V8aPlatform fakePlatform = MockCsMoneroFlutterLibsAndroidArm64V8aPlatform();
    CsMoneroFlutterLibsAndroidArm64V8aPlatform.instance = fakePlatform;

    expect(await csMoneroFlutterLibsAndroidArm64V8aPlugin.getPlatformVersion(), '42');
  });
}
