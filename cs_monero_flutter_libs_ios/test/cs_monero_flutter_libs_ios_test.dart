// import 'package:flutter_test/flutter_test.dart';
// import 'package:cs_monero_flutter_libs_ios/cs_monero_flutter_libs_ios.dart';
// import 'package:cs_monero_flutter_libs_ios/cs_monero_flutter_libs_ios_platform_interface.dart';
// import 'package:cs_monero_flutter_libs_ios/cs_monero_flutter_libs_ios_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockCsMoneroFlutterLibsIosPlatform
//     with MockPlatformInterfaceMixin
//     implements CsMoneroFlutterLibsIosPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final CsMoneroFlutterLibsIosPlatform initialPlatform = CsMoneroFlutterLibsIosPlatform.instance;
//
//   test('$MethodChannelCsMoneroFlutterLibsIos is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibsIos>());
//   });
//
//   test('getPlatformVersion', () async {
//     CsMoneroFlutterLibsIos csMoneroFlutterLibsIosPlugin = CsMoneroFlutterLibsIos();
//     MockCsMoneroFlutterLibsIosPlatform fakePlatform = MockCsMoneroFlutterLibsIosPlatform();
//     CsMoneroFlutterLibsIosPlatform.instance = fakePlatform;
//
//     expect(await csMoneroFlutterLibsIosPlugin.getPlatformVersion(), '42');
//   });
// }
