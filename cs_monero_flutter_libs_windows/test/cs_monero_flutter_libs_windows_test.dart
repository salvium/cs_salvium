// import 'package:flutter_test/flutter_test.dart';
// import 'package:cs_monero_flutter_libs_windows/cs_monero_flutter_libs_windows.dart';
// import 'package:cs_monero_flutter_libs_windows/cs_monero_flutter_libs_windows_platform_interface.dart';
// import 'package:cs_monero_flutter_libs_windows/cs_monero_flutter_libs_windows_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockCsMoneroFlutterLibsWindowsPlatform
//     with MockPlatformInterfaceMixin
//     implements CsMoneroFlutterLibsWindowsPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final CsMoneroFlutterLibsWindowsPlatform initialPlatform = CsMoneroFlutterLibsWindowsPlatform.instance;
//
//   test('$MethodChannelCsMoneroFlutterLibsWindows is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibsWindows>());
//   });
//
//   test('getPlatformVersion', () async {
//     CsMoneroFlutterLibsWindows csMoneroFlutterLibsWindowsPlugin = CsMoneroFlutterLibsWindows();
//     MockCsMoneroFlutterLibsWindowsPlatform fakePlatform = MockCsMoneroFlutterLibsWindowsPlatform();
//     CsMoneroFlutterLibsWindowsPlatform.instance = fakePlatform;
//
//     expect(await csMoneroFlutterLibsWindowsPlugin.getPlatformVersion(), '42');
//   });
// }
