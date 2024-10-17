import 'package:flutter_test/flutter_test.dart';
import 'package:cs_monero_flutter_libs/cs_monero_flutter_libs.dart';
import 'package:cs_monero_flutter_libs/cs_monero_flutter_libs_platform_interface.dart';
import 'package:cs_monero_flutter_libs/cs_monero_flutter_libs_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCsMoneroFlutterLibsPlatform
    with MockPlatformInterfaceMixin
    implements CsMoneroFlutterLibsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CsMoneroFlutterLibsPlatform initialPlatform = CsMoneroFlutterLibsPlatform.instance;

  test('$MethodChannelCsMoneroFlutterLibs is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibs>());
  });

  test('getPlatformVersion', () async {
    CsMoneroFlutterLibs csMoneroFlutterLibsPlugin = CsMoneroFlutterLibs();
    MockCsMoneroFlutterLibsPlatform fakePlatform = MockCsMoneroFlutterLibsPlatform();
    CsMoneroFlutterLibsPlatform.instance = fakePlatform;

    expect(await csMoneroFlutterLibsPlugin.getPlatformVersion(), '42');
  });
}
