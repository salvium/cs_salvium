// import 'package:flutter_test/flutter_test.dart';
// import 'package:cs_monero_flutter_libs_linux/cs_monero_flutter_libs_linux.dart';
// import 'package:cs_monero_flutter_libs_linux/cs_monero_flutter_libs_linux_platform_interface.dart';
// import 'package:cs_monero_flutter_libs_linux/cs_monero_flutter_libs_linux_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockCsMoneroFlutterLibsLinuxPlatform
//     with MockPlatformInterfaceMixin
//     implements CsMoneroFlutterLibsLinuxPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final CsMoneroFlutterLibsLinuxPlatform initialPlatform = CsMoneroFlutterLibsLinuxPlatform.instance;
//
//   test('$MethodChannelCsMoneroFlutterLibsLinux is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibsLinux>());
//   });
//
//   test('getPlatformVersion', () async {
//     CsMoneroFlutterLibsLinux csMoneroFlutterLibsLinuxPlugin = CsMoneroFlutterLibsLinux();
//     MockCsMoneroFlutterLibsLinuxPlatform fakePlatform = MockCsMoneroFlutterLibsLinuxPlatform();
//     CsMoneroFlutterLibsLinuxPlatform.instance = fakePlatform;
//
//     expect(await csMoneroFlutterLibsLinuxPlugin.getPlatformVersion(), '42');
//   });
// }
