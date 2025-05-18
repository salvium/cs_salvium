import 'package:cs_salvium_flutter_libs_platform_interface/cs_salvium_flutter_libs_platform_interface.dart';
import 'package:cs_salvium_flutter_libs_windows/cs_salvium_flutter_libs_windows.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("$CsSalviumFlutterLibsWindows", () {
    final platform = CsSalviumFlutterLibsWindows();
    const MethodChannel channel =
        MethodChannel("cs_salvium_flutter_libs_windows");

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
    CsSalviumFlutterLibsWindows.registerWith();
    expect(
      CsSalviumFlutterLibsPlatform.instance,
      isA<CsSalviumFlutterLibsWindows>(),
    );
  });
}
