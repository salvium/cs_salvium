import 'package:cs_salvium_flutter_libs_platform_interface/method_channel_cs_salvium_flutter_libs.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("$MethodChannelCsMoneroFlutterLibs", () {
    const channel = MethodChannel("cs_monero_flutter_libs");
    MethodCall? call;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        call = methodCall;
        return null;
      },
    );

    final MethodChannelCsMoneroFlutterLibs launcher =
        MethodChannelCsMoneroFlutterLibs();

    tearDown(() {
      call = null;
    });

    test("getPlatformVersion", () async {
      await launcher.getPlatformVersion();
      expect(
        call,
        isMethodCall("getPlatformVersion", arguments: null),
      );
    });
  });
}
