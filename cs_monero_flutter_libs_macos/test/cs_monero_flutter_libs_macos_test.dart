// import 'package:flutter_test/flutter_test.dart';
// import 'package:cs_monero_flutter_libs_macos/cs_monero_flutter_libs_macos.dart';
// import 'package:cs_monero_flutter_libs_macos/cs_monero_flutter_libs_macos_platform_interface.dart';
// import 'package:cs_monero_flutter_libs_macos/cs_monero_flutter_libs_macos_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockCsMoneroFlutterLibsMacosPlatform
//     with MockPlatformInterfaceMixin
//     implements CsMoneroFlutterLibsMacosPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final CsMoneroFlutterLibsMacosPlatform initialPlatform = CsMoneroFlutterLibsMacosPlatform.instance;
//
//   test('$MethodChannelCsMoneroFlutterLibsMacos is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibsMacos>());
//   });
//
//   test('getPlatformVersion', () async {
//     CsMoneroFlutterLibsMacos csMoneroFlutterLibsMacosPlugin = CsMoneroFlutterLibsMacos();
//     MockCsMoneroFlutterLibsMacosPlatform fakePlatform = MockCsMoneroFlutterLibsMacosPlatform();
//     CsMoneroFlutterLibsMacosPlatform.instance = fakePlatform;
//
//     expect(await csMoneroFlutterLibsMacosPlugin.getPlatformVersion(), '42');
//   });
// }
