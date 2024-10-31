import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'wownero_bindings_base.dart';

Pointer<Void> getWalletManager() {
  return bindings.WOWNERO_WalletManagerFactory_getWalletManager();
}

Ptr createWallet(
  Ptr walletManagerPointer, {
  required String path,
  required String password,
  String language = "English",
  int networkType = 0,
}) {
  final path_ = path.toNativeUtf8().cast<Char>();
  final password_ = password.toNativeUtf8().cast<Char>();
  final language_ = language.toNativeUtf8().cast<Char>();
  final w = bindings.WOWNERO_WalletManager_createWallet(
      walletManagerPointer, path_, password_, language_, networkType);
  calloc.free(path_);
  calloc.free(password_);
  calloc.free(language_);
  return w;
}

Ptr openWallet(
  Ptr walletManagerPointer, {
  required String path,
  required String password,
  int networkType = 0,
}) {
  final path_ = path.toNativeUtf8().cast<Char>();
  final password_ = password.toNativeUtf8().cast<Char>();
  final w = bindings.WOWNERO_WalletManager_openWallet(
      walletManagerPointer, path_, password_, networkType);
  calloc.free(path_);
  calloc.free(password_);
  return w;
}

Ptr recoveryWallet(
  Ptr walletManagerPointer, {
  required String path,
  required String password,
  required String mnemonic,
  int networkType = 0,
  required int restoreHeight,
  int kdfRounds = 0,
  required String seedOffset,
}) {
  final path_ = path.toNativeUtf8().cast<Char>();
  final password_ = password.toNativeUtf8().cast<Char>();
  final mnemonic_ = mnemonic.toNativeUtf8().cast<Char>();
  final seedOffset_ = seedOffset.toNativeUtf8().cast<Char>();
  final w = bindings.WOWNERO_WalletManager_recoveryWallet(
      walletManagerPointer,
      path_,
      password_,
      mnemonic_,
      networkType,
      restoreHeight,
      kdfRounds,
      seedOffset_);
  calloc.free(path_);
  calloc.free(password_);
  calloc.free(mnemonic_);
  calloc.free(seedOffset_);
  return w;
}

Ptr createWalletFromKeys(
  Ptr walletManagerPointer, {
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
  final path_ = path.toNativeUtf8().cast<Char>();
  final password_ = password.toNativeUtf8().cast<Char>();
  final language_ = language.toNativeUtf8().cast<Char>();
  final addressString_ = addressString.toNativeUtf8().cast<Char>();
  final viewKeyString_ = viewKeyString.toNativeUtf8().cast<Char>();
  final spendKeyString_ = spendKeyString.toNativeUtf8().cast<Char>();

  final w = bindings.WOWNERO_WalletManager_createWalletFromKeys(
    walletManagerPointer,
    path_,
    password_,
    language_,
    networkType,
    restoreHeight,
    addressString_,
    viewKeyString_,
    spendKeyString_,
    kdfRounds,
  );
  calloc.free(path_);
  calloc.free(password_);
  calloc.free(language_);
  calloc.free(addressString_);
  calloc.free(viewKeyString_);
  calloc.free(spendKeyString_);
  return w;
}

Ptr createDeterministicWalletFromSpendKey(
  Ptr walletManagerPointer, {
  required String path,
  required String password,
  int networkType = 0,
  required String language,
  required String spendKeyString,
  required bool newWallet,
  required int restoreHeight,
  int kdfRounds = 1,
}) {
  final path_ = path.toNativeUtf8().cast<Char>();
  final password_ = password.toNativeUtf8().cast<Char>();
  final language_ = language.toNativeUtf8().cast<Char>();
  final spendKeyString_ = spendKeyString.toNativeUtf8().cast<Char>();
  final w =
      bindings.WOWNERO_WalletManager_createDeterministicWalletFromSpendKey(
          walletManagerPointer,
          path_,
          password_,
          language_,
          networkType,
          restoreHeight,
          spendKeyString_,
          kdfRounds);
  calloc.free(path_);
  calloc.free(password_);
  calloc.free(language_);
  calloc.free(spendKeyString_);
  return w;
}

Ptr createWalletFromPolyseed(
  Ptr walletManagerPointer, {
  required String path,
  required String password,
  int networkType = 0,
  required String mnemonic,
  required String seedOffset,
  required bool newWallet,
  required int restoreHeight,
  required int kdfRounds,
}) {
  final path_ = path.toNativeUtf8().cast<Char>();
  final password_ = password.toNativeUtf8().cast<Char>();
  final mnemonic_ = mnemonic.toNativeUtf8().cast<Char>();
  final seedOffset_ = seedOffset.toNativeUtf8().cast<Char>();
  final w = bindings.WOWNERO_WalletManager_createWalletFromPolyseed(
      walletManagerPointer,
      path_,
      password_,
      networkType,
      mnemonic_,
      seedOffset_,
      newWallet,
      restoreHeight,
      kdfRounds);
  calloc.free(path_);
  calloc.free(password_);
  calloc.free(mnemonic_);
  calloc.free(seedOffset_);
  return w;
}

bool closeWallet(Ptr walletManagerPointer, Ptr walletPointer, bool store) {
  final closeWallet = bindings.WOWNERO_WalletManager_closeWallet(
    walletManagerPointer,
    walletPointer,
    store,
  );
  return closeWallet;
}

bool walletExists(Ptr walletManagerPointer, String path) {
  final path_ = path.toNativeUtf8().cast<Char>();
  final s = bindings.WOWNERO_WalletManager_walletExists(
    walletManagerPointer,
    path_,
  );
  calloc.free(path_);
  return s;
}
