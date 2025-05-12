import 'package:cs_salvium_flutter_libs_linux/cs_salvium_flutter_libs_linux.dart';
import 'package:cs_salvium_flutter_libs_platform_interface/cs_salvium_flutter_libs_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("$CsMoneroFlutterLibsLinux", () {
    final platform = CsMoneroFlutterLibsLinux();
    const MethodChannel channel = MethodChannel('cs_salvium_flutter_libs_linux');

    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return '42';
        },
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('getPlatformVersion', () async {
      expect(await platform.getPlatformVersion(), '42');
    });
  });

  test("registerWith", () {
    CsMoneroFlutterLibsLinux.registerWith();
    expect(
      CsMoneroFlutterLibsPlatform.instance,
      isA<CsMoneroFlutterLibsLinux>(),
    );
  });
}
