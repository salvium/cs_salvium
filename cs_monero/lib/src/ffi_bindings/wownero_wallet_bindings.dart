import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'wownero_bindings_base.dart';

/// Will throw on failure
void checkWalletStatus(Ptr walletPointer) {
  final status = bindings.WOWNERO_Wallet_status(walletPointer);

  if (status == 0) {
    return;
  }
  final strPtr =
      bindings.WOWNERO_Wallet_errorString(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  throw Exception(str);
}

bool storeWallet(Ptr walletPointer, {required String path}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_store(walletPointer, pathPointer);
  } finally {
    calloc.free(pathPointer);
  }
}

bool initWallet(
  Ptr walletPointer, {
  required String daemonAddress,
  int upperTransactionSizeLimit = 0,
  String daemonUsername = "",
  String daemonPassword = "",
  bool useSsl = false,
  bool lightWallet = false,
  String proxyAddress = "",
}) {
  final daemonAddressPointer = daemonAddress.toNativeUtf8().cast<Char>();
  final daemonUsernamePointer = daemonUsername.toNativeUtf8().cast<Char>();
  final daemonPasswordPointer = daemonPassword.toNativeUtf8().cast<Char>();
  final proxyAddressPointer = proxyAddress.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_init(
      walletPointer,
      daemonAddressPointer,
      upperTransactionSizeLimit,
      daemonUsernamePointer,
      daemonPasswordPointer,
      useSsl,
      lightWallet,
      proxyAddressPointer,
    );
  } finally {
    calloc.free(daemonAddressPointer);
    calloc.free(daemonUsernamePointer);
    calloc.free(daemonPasswordPointer);
    calloc.free(proxyAddressPointer);
  }
}

void setTrustedDaemon(Ptr walletPointer, {required bool arg}) {
  bindings.WOWNERO_Wallet_setTrustedDaemon(walletPointer, arg);
}

bool isWatchOnly(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_watchOnly(walletPointer);
}

int isConnected(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_connected(walletPointer);
}

bool isSynchronized(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_synchronized(walletPointer);
}

String getWalletPath(Ptr walletPointer) {
  final strPtr = bindings.WOWNERO_Wallet_path(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

// =============================================================================
// ============== Address ======================================================

bool validateAddress(String address, int networkType) {
  final addressPointer = address.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_addressValid(addressPointer, networkType);
  } finally {
    calloc.free(addressPointer);
  }
}

String getWalletAddress(
  Ptr walletPointer, {
  int accountIndex = 0,
  int addressIndex = 0,
}) {
  final strPtr = bindings.WOWNERO_Wallet_address(
    walletPointer,
    accountIndex,
    addressIndex,
  ).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

// =============================================================================
// ============== Chain ========================================================

int getWalletBlockChainHeight(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_blockChainHeight(walletPointer);
}

int getDaemonBlockChainHeight(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_daemonBlockChainHeight(walletPointer);
}

void setWalletRefreshFromBlockHeight(
  Ptr walletPointer, {
  required int refreshFromBlockHeight,
}) {
  bindings.WOWNERO_Wallet_setRefreshFromBlockHeight(
    walletPointer,
    refreshFromBlockHeight,
  );
}

int getWalletRefreshFromBlockHeight(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_getRefreshFromBlockHeight(walletPointer);
}

void setWalletAutoRefreshInterval(Ptr walletPointer, {required int millis}) {
  bindings.WOWNERO_Wallet_setAutoRefreshInterval(walletPointer, millis);
}

void refreshWalletAsync(Ptr walletPointer) {
  bindings.WOWNERO_Wallet_refreshAsync(walletPointer);
}

void startWalletRefresh(Ptr walletPointer) {
  bindings.WOWNERO_Wallet_startRefresh(walletPointer);
}

void pauseWalletRefresh(Ptr walletPointer) {
  bindings.WOWNERO_Wallet_pauseRefresh(walletPointer);
}

void stopWallet(Ptr walletPointer) {
  bindings.WOWNERO_Wallet_stop(walletPointer);
}

bool rescanWalletBlockchain(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_rescanBlockchain(walletPointer);
}

// =============================================================================
// ============== Balance ======================================================

int getWalletBalance(Ptr walletPointer, {required int accountIndex}) {
  return bindings.WOWNERO_Wallet_balance(walletPointer, accountIndex);
}

int getWalletUnlockedBalance(Ptr walletPointer, {required int accountIndex}) {
  return bindings.WOWNERO_Wallet_unlockedBalance(walletPointer, accountIndex);
}

// =============================================================================
// ============== History/Transactions =========================================

String getTxKey(Ptr walletPointer, {required String txid}) {
  final txidPointer = txid.toNativeUtf8().cast<Char>();
  try {
    final strPtr = bindings.WOWNERO_Wallet_getTxKey(
      walletPointer,
      txidPointer,
    ).cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());
    return str;
  } finally {
    calloc.free(txidPointer);
  }
}

Ptr getTransactionHistoryPointer(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_history(walletPointer);
}

void refreshTransactionHistory(Ptr txHistoryPointer) {
  bindings.WOWNERO_TransactionHistory_refresh(txHistoryPointer);
}

int getTransactionHistoryCount(Ptr txHistoryPointer) {
  return bindings.WOWNERO_TransactionHistory_count(txHistoryPointer);
}

Ptr getTransactionInfoPointer(
  Ptr txHistoryPointer, {
  required int index,
}) {
  return bindings.WOWNERO_TransactionHistory_transaction(
    txHistoryPointer,
    index,
  );
}

Ptr getTransactionInfoPointerByTxid(
  Ptr txHistoryPointer, {
  required String txid,
}) {
  final txidPointer = txid.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_TransactionHistory_transactionById(
      txHistoryPointer,
      txidPointer,
    );
  } finally {
    calloc.free(txidPointer);
  }
}

// =============================================================================
// ============== Transactions =================================================

Ptr createTransaction(
  Ptr walletPointer, {
  required String address,
  required String paymentId,
  required int amount,
  required int pendingTransactionPriority,
  required int subaddressAccount,
  List<String> preferredInputs = const [],
}) {
  final addressPointer = address.toNativeUtf8().cast<Char>();
  final paymentIdPointer = paymentId.toNativeUtf8().cast<Char>();
  final preferredInputsPointer = preferredInputs
      .join(
        defaultSeparatorStr,
      )
      .toNativeUtf8()
      .cast<Char>();

  try {
    return bindings.WOWNERO_Wallet_createTransaction(
      walletPointer,
      addressPointer,
      paymentIdPointer,
      amount,
      0, // mixin count/ring size. Ignored here, core code will use appropriate value
      pendingTransactionPriority,
      subaddressAccount,
      preferredInputsPointer,
      defaultSeparator,
    );
  } finally {
    calloc.free(addressPointer);
    calloc.free(paymentIdPointer);
    calloc.free(preferredInputsPointer);
  }
}

Ptr createTransactionMultiDest(
  Ptr walletPointer, {
  required List<String> addresses,
  required String paymentId,
  required bool isSweepAll,
  required List<int> amounts,
  required int pendingTransactionPriority,
  required int subaddressAccount,
  List<String> preferredInputs = const [],
}) {
  final addressesPointer = addresses.join(defaultSeparatorStr).toNativeUtf8();
  final paymentIdPointer = paymentId.toNativeUtf8();
  final amountsPointer = amounts
      .map((e) => e.toString())
      .join(
        defaultSeparatorStr,
      )
      .toNativeUtf8();
  final preferredInputsPointer = preferredInputs
      .join(
        defaultSeparatorStr,
      )
      .toNativeUtf8();

  try {
    return bindings.WOWNERO_Wallet_createTransactionMultDest(
      walletPointer,
      addressesPointer.cast(),
      defaultSeparator,
      paymentIdPointer.cast(),
      isSweepAll,
      amountsPointer.cast(),
      defaultSeparator,
      0, // mixin count/ring size. Ignored here, core code will use appropriate value
      pendingTransactionPriority,
      subaddressAccount,
      preferredInputsPointer.cast(),
      defaultSeparator,
    );
  } finally {
    calloc.free(addressesPointer);
    calloc.free(paymentIdPointer);
    calloc.free(amountsPointer);
    calloc.free(preferredInputsPointer);
  }
}

// =============================================================================
// ============== Pending Transaction ==========================================

/// Will throw on failure
void checkPendingTransactionStatus(Ptr pendingTransactionPointer) {
  final status = bindings.WOWNERO_PendingTransaction_status(
    pendingTransactionPointer,
  );
  if (status == 0) {
    return;
  }
  final strPtr = bindings.WOWNERO_PendingTransaction_errorString(
    pendingTransactionPointer,
  ).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  throw Exception(str);
}

int getPendingTransactionAmount(Ptr pendingTransactionPointer) {
  return bindings.WOWNERO_PendingTransaction_amount(pendingTransactionPointer);
}

int getPendingTransactionFee(Ptr pendingTransactionPointer) {
  return bindings.WOWNERO_PendingTransaction_fee(pendingTransactionPointer);
}

String getPendingTransactionTxid(
  Ptr pendingTransactionPointer, {
  String separator = "",
}) {
  final separatorPointer = separator.toNativeUtf8().cast<Char>();
  try {
    final strPtr = bindings.WOWNERO_PendingTransaction_txid(
      pendingTransactionPointer,
      separatorPointer,
    ).cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());
    return str;
  } finally {
    calloc.free(separatorPointer);
  }
}

String getPendingTransactionHex(
  Ptr pendingTransactionPointer, {
  String separator = "",
}) {
  final separatorPointer = separator.toNativeUtf8().cast<Char>();
  try {
    final strPtr = bindings.WOWNERO_PendingTransaction_hex(
      pendingTransactionPointer,
      separatorPointer,
    ).cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());
    return str;
  } finally {
    calloc.free(separatorPointer);
  }
}

bool commitPendingTransaction(
  Ptr pendingTransactionPointer, {
  String filename = "",
  bool overwrite = false,
}) {
  final filenamePointer = filename.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_PendingTransaction_commit(
      pendingTransactionPointer,
      filenamePointer,
      overwrite,
    );
  } finally {
    calloc.free(filenamePointer);
  }
}

// =============================================================================
// ============== Coins ========================================================

Ptr getCoinsPointer(Ptr walletPointer) {
  return bindings.WOWNERO_Wallet_coins(walletPointer);
}

void refreshCoins(Ptr coinsPointer) {
  bindings.WOWNERO_Coins_refresh(coinsPointer);
}

int getCoinsCount(Ptr coinsPointer) {
  return bindings.WOWNERO_Coins_count(coinsPointer);
}

int getAllCoinsSize(Ptr coinsPointer) {
  return bindings.WOWNERO_Coins_getAll_size(coinsPointer);
}

Ptr getCoinInfoPointer(Ptr coinsPointer, int index) {
  return bindings.WOWNERO_Coins_coin(coinsPointer, index);
}

void freezeCoin(Ptr coinsPointer, {required int index}) {
  bindings.WOWNERO_Coins_setFrozen(coinsPointer, index);
}

void thawCoin(Ptr coinsPointer, {required int index}) {
  bindings.WOWNERO_Coins_thaw(coinsPointer, index);
}

// =============================================================================
// ============== Coins Info ===================================================

int getInternalOutputIndexForCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_internalOutputIndex(coinsInfoPointer);
}

bool isFrozenCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_frozen(coinsInfoPointer);
}

bool isSpentCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_spent(coinsInfoPointer);
}

int getSpentHeightForCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_spentHeight(coinsInfoPointer);
}

int getAmountForCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_amount(coinsInfoPointer);
}

int getBlockHeightForCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_blockHeight(coinsInfoPointer);
}

bool isUnlockedCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_unlocked(coinsInfoPointer);
}

bool isCoinbaseCoinsInfo(Ptr coinsInfoPointer) {
  return bindings.WOWNERO_CoinsInfo_coinbase(coinsInfoPointer);
}

String getAddressForCoinsInfo(Ptr coinsInfoPointer) {
  final strPtr = bindings.WOWNERO_CoinsInfo_address(
    coinsInfoPointer,
  ).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getKeyImageForCoinsInfo(Ptr coinsInfoPointer) {
  final strPtr = bindings.WOWNERO_CoinsInfo_keyImage(
    coinsInfoPointer,
  ).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getHashForCoinsInfo(Ptr coinsInfoPointer) {
  final strPtr = bindings.WOWNERO_CoinsInfo_hash(coinsInfoPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

// =============================================================================
// ============== Key Images ===================================================

bool exportWalletKeyImages(
  Ptr walletPointer,
  String filename, {
  required bool all,
}) {
  final filenamePointer = filename.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_exportKeyImages(
      walletPointer,
      filenamePointer,
      all,
    );
  } finally {
    calloc.free(filenamePointer);
  }
}

bool importWalletKeyImages(Ptr walletPointer, String filename) {
  final filenamePointer = filename.toNativeUtf8().cast<Char>();

  try {
    return bindings.WOWNERO_Wallet_importKeyImages(
      walletPointer,
      filenamePointer,
    );
  } finally {
    calloc.free(filenamePointer);
  }
}

// =============================================================================
// ============== Sign/Verify ==================================================

String signMessageWith(
  Ptr walletPointer, {
  required String message,
  required String address,
}) {
  final messagePointer = message.toNativeUtf8().cast<Char>();
  final addressPointer = address.toNativeUtf8().cast<Char>();
  try {
    final strPtr = bindings.WOWNERO_Wallet_signMessage(
      walletPointer,
      messagePointer,
      addressPointer,
    ).cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());
    return str;
  } finally {
    calloc.free(messagePointer);
    calloc.free(addressPointer);
  }
}

bool verifySignedMessageWithWallet(
  Ptr walletPointer, {
  required String message,
  required String address,
  required String signature,
}) {
  final messagePointer = message.toNativeUtf8().cast<Char>();
  final addressPointer = address.toNativeUtf8().cast<Char>();
  final signaturePointer = signature.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_verifySignedMessage(
      walletPointer,
      messagePointer,
      addressPointer,
      signaturePointer,
    );
  } finally {
    calloc.free(messagePointer);
    calloc.free(addressPointer);
    calloc.free(signaturePointer);
  }
}

// =============================================================================
// ============== Seed/Password ================================================

String getWalletSeed(Ptr walletPointer, {required String seedOffset}) {
  final seedOffsetPointer = seedOffset.toNativeUtf8().cast<Char>();
  try {
    final strPtr =
        bindings.WOWNERO_Wallet_seed(walletPointer, seedOffsetPointer)
            .cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());
    return str;
  } finally {
    calloc.free(seedOffsetPointer);
  }
}

String getWalletSeedLanguage(Ptr walletPointer) {
  final strPtr =
      bindings.WOWNERO_Wallet_getSeedLanguage(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getWalletPolyseed(Ptr walletPointer, {required String passphrase}) {
  final passphrasePointer = passphrase.toNativeUtf8().cast<Char>();
  try {
    final strPtr =
        bindings.WOWNERO_Wallet_getPolyseed(walletPointer, passphrasePointer)
            .cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());

    return str;
  } finally {
    calloc.free(passphrasePointer);
  }
}

String createPolyseed({String language = "English"}) {
  final languagePointer = language.toNativeUtf8();
  try {
    final strPtr = bindings.WOWNERO_Wallet_createPolyseed(
      languagePointer.cast(),
    ).cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());
    return str;
  } finally {
    calloc.free(languagePointer);
  }
}

bool setWalletPassword(Ptr walletPointer, {required String password}) {
  final password_ = password.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_setPassword(walletPointer, password_);
  } finally {
    calloc.free(password_);
  }
}

String getWalletPassword(Ptr walletPointer) {
  final strPtr =
      bindings.WOWNERO_Wallet_getPassword(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

// =============================================================================
// ============== Keys =========================================================

String getWalletSecretViewKey(Ptr walletPointer) {
  final strPtr =
      bindings.WOWNERO_Wallet_secretViewKey(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getWalletPublicViewKey(Ptr walletPointer) {
  final strPtr =
      bindings.WOWNERO_Wallet_publicViewKey(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getWalletSecretSpendKey(Ptr walletPointer) {
  final strPtr =
      bindings.WOWNERO_Wallet_secretSpendKey(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getWalletPublicSpendKey(Ptr walletPointer) {
  final strPtr =
      bindings.WOWNERO_Wallet_publicSpendKey(walletPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

// =============================================================================
// ============== TransactionInfo ==============================================

int getTransactionInfoAmount(Ptr txInfoPointer) {
  return bindings.WOWNERO_TransactionInfo_amount(txInfoPointer);
}

int getTransactionInfoFee(Ptr txInfoPointer) {
  return bindings.WOWNERO_TransactionInfo_fee(txInfoPointer);
}

int getTransactionInfoConfirmations(Ptr txInfoPointer) {
  return bindings.WOWNERO_TransactionInfo_confirmations(txInfoPointer);
}

int getTransactionInfoBlockHeight(Ptr txInfoPointer) {
  return bindings.WOWNERO_TransactionInfo_blockHeight(txInfoPointer);
}

int getTransactionInfoTimestamp(Ptr txInfoPointer) {
  return bindings.WOWNERO_TransactionInfo_timestamp(txInfoPointer);
}

int getTransactionInfoAccount(Ptr txInfoPointer) {
  return bindings.WOWNERO_TransactionInfo_subaddrAccount(txInfoPointer);
}

Set<int> getTransactionSubaddressIndexes(Ptr txInfoPointer) {
  final strPtr = bindings.WOWNERO_TransactionInfo_subaddrIndex(
          txInfoPointer, defaultSeparator)
      .cast<Utf8>();
  final indexesString = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  final indexes = indexesString.split(", ").map(int.parse);
  return indexes.toSet();
}

bool getTransactionInfoIsSpend(Ptr txInfoPointer) {
  // 0 is incoming, 1 is outgoing
  return bindings.WOWNERO_TransactionInfo_direction(txInfoPointer) == 1;
}

String getTransactionInfoLabel(Ptr txInfoPointer) {
  final strPtr =
      bindings.WOWNERO_TransactionInfo_label(txInfoPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getTransactionInfoDescription(Ptr txInfoPointer) {
  final strPtr =
      bindings.WOWNERO_TransactionInfo_description(txInfoPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getTransactionInfoPaymentId(Ptr txInfoPointer) {
  final strPtr =
      bindings.WOWNERO_TransactionInfo_paymentId(txInfoPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

String getTransactionInfoHash(Ptr txInfoPointer) {
  final strPtr =
      bindings.WOWNERO_TransactionInfo_hash(txInfoPointer).cast<Utf8>();
  final str = strPtr.toDartString();
  bindings.WOWNERO_free(strPtr.cast());
  return str;
}

// =============================================================================
// ============== Other ========================================================

int amountFromString(String amount) {
  final amount_ = amount.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_amountFromString(amount_);
  } finally {
    calloc.free(amount_);
  }
}

bool setWalletCacheAttribute(
  Ptr walletPointer, {
  required String key,
  required String value,
}) {
  final keyPointer = key.toNativeUtf8().cast<Char>();
  final valuePointer = value.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_Wallet_setCacheAttribute(
      walletPointer,
      keyPointer,
      valuePointer,
    );
  } finally {
    calloc.free(keyPointer);
    calloc.free(valuePointer);
  }
}

String getWalletCacheAttribute(
  Ptr walletPointer, {
  required String key,
}) {
  final keyPointer = key.toNativeUtf8().cast<Char>();
  try {
    final strPtr = bindings.WOWNERO_Wallet_getCacheAttribute(
      walletPointer,
      keyPointer,
    ).cast<Utf8>();
    final str = strPtr.toDartString();
    bindings.WOWNERO_free(strPtr.cast());

    return str;
  } finally {
    calloc.free(keyPointer);
  }
}

// wow specific

Ptr restore14WordSeed({
  required String path,
  required String password,
  required String language,
  required int networkType,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = path.toNativeUtf8().cast<Char>();
  final languagePointer = path.toNativeUtf8().cast<Char>();
  try {
    return bindings.WOWNERO_deprecated_restore14WordSeed(
      pathPointer.cast(),
      passwordPointer.cast(),
      languagePointer.cast(),
      networkType,
    );
  } finally {
    calloc.free(pathPointer);
    calloc.free(passwordPointer);
    calloc.free(languagePointer);
  }
}

Ptr create14WordSeed({
  required String path,
  required String password,
  required String language,
  required int networkType,
}) {
  final pathPointer = path.toNativeUtf8().cast<Char>();
  final passwordPointer = path.toNativeUtf8().cast<Char>();
  final languagePointer = path.toNativeUtf8().cast<Char>();

  try {
    return bindings.WOWNERO_deprecated_create14WordSeed(
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
