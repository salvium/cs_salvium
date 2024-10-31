import 'dart:ffi';
import 'dart:io';

import 'package:cs_monero/src/ffi_bindings/generated_bindings_wownero.g.dart';
import 'package:ffi/ffi.dart';

String get _libName {
  if (Platform.isIOS || Platform.isMacOS) {
    return 'WowneroWallet.framework/WowneroWallet';
  } else if (Platform.isAndroid) {
    return 'libwownero_libwallet2_api_c.so';
  } else if (Platform.isWindows) {
    return 'wownero_libwallet2_api_c.dll';
  } else if (Platform.isLinux) {
    return 'wownero_libwallet2_api_c.so';
  } else {
    throw UnsupportedError(
      "Platform \"${Platform.operatingSystem}\" is not supported",
    );
  }
}

FfiWowneroC? _cachedBindings;
FfiWowneroC get bindings => _cachedBindings ??= FfiWowneroC(
      DynamicLibrary.open(
        _libName,
      ),
    );

typedef Ptr = Pointer<Void>;

final defaultSeparatorStr = ";";
final defaultSeparator = defaultSeparatorStr.toNativeUtf8().cast<Char>();
