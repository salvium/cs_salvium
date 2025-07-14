import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'generated_bindings_salvium.g.dart';

String get _libName {
  if (Platform.isMacOS) {
    return 'SalviumWallet.framework/SalviumWallet';
  } else if (Platform.isAndroid) {
    return 'libsalvium_libwallet2_api_c.so';
  } else if (Platform.isWindows) {
    return 'salvium_libwallet2_api_c.dll';
  } else if (Platform.isLinux) {
    return 'salvium_libwallet2_api_c.so';
  } else {
    throw UnsupportedError(
      "Platform \"${Platform.operatingSystem}\" is not supported",
    );
  }
}

FfiSalviumC? _cachedBindings;
FfiSalviumC get bindings => _cachedBindings ??= FfiSalviumC(
      Platform.isIOS
          ? DynamicLibrary.process()
          : DynamicLibrary.open(
              _libName,
            ),
    );

final defaultSeparatorStr = ";";
final defaultSeparator = defaultSeparatorStr.toNativeUtf8().cast<Char>();

String convertAndFree(Pointer<Utf8> stringPointer) {
  final value = stringPointer.toDartString();
  bindings.SALVIUM_free(stringPointer.cast());
  return value;
}
