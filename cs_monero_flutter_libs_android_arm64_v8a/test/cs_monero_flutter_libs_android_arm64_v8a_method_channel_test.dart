import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cs_monero_flutter_libs_android_arm64_v8a/cs_monero_flutter_libs_android_arm64_v8a_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCsMoneroFlutterLibsAndroidArm64V8a platform = MethodChannelCsMoneroFlutterLibsAndroidArm64V8a();
  const MethodChannel channel = MethodChannel('cs_monero_flutter_libs_android_arm64_v8a');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
