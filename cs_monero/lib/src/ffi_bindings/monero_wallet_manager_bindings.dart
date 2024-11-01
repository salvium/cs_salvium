import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'monero_bindings_base.dart';

Pointer<Void> getWalletManager() {
  return bindings.MONERO_WalletManagerFactory_getWalletManager();
}

Pointer<Void> createWallet(
  Pointer<Void> walletManagerPointer, {
  required String path,
  required String password,
  String language = "English",
  int networkType = 0,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = password.toNativeUtf8().cast<Char>();
  final languagePointer = language.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_createWallet(
      walletManagerPointer,
      pathPointer,
      passwordPointer,
      languagePointer,
      networkType,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
    calloc.free(languagePointer);
  }
}

Pointer<Void> openWallet(
  Pointer<Void> walletManagerPointer, {
  required String path,
  required String password,
  int networkType = 0,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = password.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_openWallet(
      walletManagerPointer,
      pathPointer,
      passwordPointer,
      networkType,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
  }
}

Pointer<Void> recoveryWallet(
  Pointer<Void> walletManagerPointer, {
  required String path,
  required String password,
  required String mnemonic,
  int networkType = 0,
  required int restoreHeight,
  int kdfRounds = 0,
  required String seedOffset,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = password.toNativeUtf8().cast<Char>();
  final mnemonicPointer = mnemonic.toNativeUtf8().cast<Char>();
  final seedOffsetPointer = seedOffset.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_recoveryWallet(
      walletManagerPointer,
      pathPointer,
      passwordPointer,
      mnemonicPointer,
      networkType,
      restoreHeight,
      kdfRounds,
      seedOffsetPointer,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
    calloc.free(mnemonicPointer);
    calloc.free(seedOffsetPointer);
  }
}

Pointer<Void> createWalletFromKeys(
  Pointer<Void> walletManagerPointer, {
  required String path,
  required String password,
  String language = "English",
  int networkType = 1,
  required int restoreHeight,
  required String addressString,
  required String viewKeyString,
  required String spendKeyString,
  int kdfRounds = 1,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = password.toNativeUtf8().cast<Char>();
  final languagePointer = language.toNativeUtf8().cast<Char>();
  final addressStringPointer = addressString.toNativeUtf8().cast<Char>();
  final viewKeyStringPointer = viewKeyString.toNativeUtf8().cast<Char>();
  final spendKeyStringPointer = spendKeyString.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_createWalletFromKeys(
      walletManagerPointer,
      pathPointer,
      passwordPointer,
      languagePointer,
      networkType,
      restoreHeight,
      addressStringPointer,
      viewKeyStringPointer,
      spendKeyStringPointer,
      kdfRounds,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
    calloc.free(languagePointer);
    calloc.free(addressStringPointer);
    calloc.free(viewKeyStringPointer);
    calloc.free(spendKeyStringPointer);
  }
}

Pointer<Void> createDeterministicWalletFromSpendKey(
  Pointer<Void> walletManagerPointer, {
  required String path,
  required String password,
  int networkType = 0,
  required String language,
  required String spendKeyString,
  required bool newWallet,
  required int restoreHeight,
  int kdfRounds = 1,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = password.toNativeUtf8().cast<Char>();
  final languagePointer = language.toNativeUtf8().cast<Char>();
  final spendKeyStringPointer = spendKeyString.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_createDeterministicWalletFromSpendKey(
      walletManagerPointer,
      pathPointer,
      passwordPointer,
      languagePointer,
      networkType,
      restoreHeight,
      spendKeyStringPointer,
      kdfRounds,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
    calloc.free(languagePointer);
    calloc.free(spendKeyStringPointer);
  }
}

Pointer<Void> createWalletFromPolyseed(
  Pointer<Void> walletManagerPointer, {
  required String path,
  required String password,
  int networkType = 0,
  required String mnemonic,
  required String seedOffset,
  required bool newWallet,
  required int restoreHeight,
  required int kdfRounds,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = password.toNativeUtf8().cast<Char>();
  final mnemonicPointer = mnemonic.toNativeUtf8().cast<Char>();
  final seedOffsetPointer = seedOffset.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_createWalletFromPolyseed(
      walletManagerPointer,
      pathPointer,
      passwordPointer,
      networkType,
      mnemonicPointer,
      seedOffsetPointer,
      newWallet,
      restoreHeight,
      kdfRounds,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
    calloc.free(mnemonicPointer);
    calloc.free(seedOffsetPointer);
  }
}

bool closeWallet(
  Pointer<Void> walletManagerPointer,
  Pointer<Void> walletPointer,
  bool store,
) {
  final closeWallet = bindings.MONERO_WalletManager_closeWallet(
    walletManagerPointer,
    walletPointer,
    store,
  );
  return closeWallet;
}

bool walletExists(Pointer<Void> walletManagerPointer, String path) {
  final pathPointer = path.toNativeUtf8().cast<Char>();

  try {
    return bindings.MONERO_WalletManager_walletExists(
      walletManagerPointer,
      pathPointer,
    );
  } finally {
    calloc.free(pathPointer);
  }
}
