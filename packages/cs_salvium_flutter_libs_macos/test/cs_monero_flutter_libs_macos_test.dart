import 'package:cs_salvium_flutter_libs_macos/cs_salvium_flutter_libs_macos.dart';
import 'package:cs_salvium_flutter_libs_platform_interface/cs_monero_flutter_libs_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("$CsMoneroFlutterLibsMacos", () {
    final platform = CsMoneroFlutterLibsMacos();
    const MethodChannel channel = MethodChannel("cs_monero_flutter_libs_macos");

    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return "42";
        },
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test("getPlatformVersion", () async {
      expect(await platform.getPlatformVersion(), "42");
    });
  });

  test("registerWith", () {
    CsMoneroFlutterLibsMacos.registerWith();
    expect(
      CsMoneroFlutterLibsPlatform.instance,
      isA<CsMoneroFlutterLibsMacos>(),
    );
  });
}
