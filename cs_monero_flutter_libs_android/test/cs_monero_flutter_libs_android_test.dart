// import 'package:flutter_test/flutter_test.dart';
// import 'package:cs_monero_flutter_libs_android/cs_monero_flutter_libs_android.dart';
// import 'package:cs_monero_flutter_libs_android/cs_monero_flutter_libs_android_platform_interface.dart';
// import 'package:cs_monero_flutter_libs_android/cs_monero_flutter_libs_android_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockCsMoneroFlutterLibsAndroidPlatform
//     with MockPlatformInterfaceMixin
//     implements CsMoneroFlutterLibsAndroidPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final CsMoneroFlutterLibsAndroidPlatform initialPlatform = CsMoneroFlutterLibsAndroidPlatform.instance;
//
//   test('$MethodChannelCsMoneroFlutterLibsAndroid is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelCsMoneroFlutterLibsAndroid>());
//   });
//
//   test('getPlatformVersion', () async {
//     CsMoneroFlutterLibsAndroid csMoneroFlutterLibsAndroidPlugin = CsMoneroFlutterLibsAndroid();
//     MockCsMoneroFlutterLibsAndroidPlatform fakePlatform = MockCsMoneroFlutterLibsAndroidPlatform();
//     CsMoneroFlutterLibsAndroidPlatform.instance = fakePlatform;
//
//     expect(await csMoneroFlutterLibsAndroidPlugin.getPlatformVersion(), '42');
//   });
// }
