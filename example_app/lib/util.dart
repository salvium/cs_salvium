import 'dart:io';

import 'package:cs_monero/cs_monero.dart';
import 'package:path_provider/path_provider.dart';

Future<String> pathForWalletDir({
  required String name,
  required String type,
}) async {
  Directory root = await getApplicationDocumentsDirectory();
  if (Platform.isIOS) {
    root = (await getLibraryDirectory());
  }

  final walletsDir = Directory('${root.path}${Platform.pathSeparator}wallets');
  final walletDire = Directory(
      '${walletsDir.path}${Platform.pathSeparator}$type${Platform.pathSeparator}$name');

  if (!walletDire.existsSync()) {
    walletDire.createSync(recursive: true);
  }

  return walletDire.path;
}

Future<String> pathForWallet({
  required String name,
  required String type,
}) async =>
    await pathForWalletDir(name: name, type: type)
        .then((path) => '$path${Platform.pathSeparator}$name');

Future<List<String>> loadWalletNames(String walletType) async {
  String path = await pathForWalletDir(name: "dummy", type: walletType);

  path = path.substring(0, path.lastIndexOf("${Platform.pathSeparator}dummy"));

  final dir = Directory(path);

  if (!dir.existsSync()) {
    return [];
  }

  final names = dir
      .listSync()
      .whereType<Directory>()
      .map((e) => e.path.split(Platform.pathSeparator).last)
      .toList();
  names.remove("dummy");

  return names;
}

Future<void> printWalletInfo(Wallet wallet) async {
  await wallet.refreshTransactions();
  await wallet.refreshOutputs();
  final connected = await wallet.isConnectedToDaemon();
  final txCount = wallet.transactionCount();
  final outputCount = (await wallet.getOutputs(includeSpent: true)).length;

  print("====================================================================");
  print("connected: $connected");
  print("outputCount: $outputCount");
  print("txCount: $txCount");
  print("balance: ${wallet.getBalance()}");
  print("unlocked: ${wallet.getUnlockedBalance()}");
  print("syncHeight: ${wallet.syncHeight()}");
  print("daemonHeight: ${wallet.getDaemonHeight()}");
  print("mnemonic: ${wallet.getSeed()}");
  print("address: ${wallet.getAddress()}");
  print("sync from height: ${wallet.getSyncFromBlockHeight()}");
  print("daemonHeight: ${wallet.getDaemonHeight()}");
  print("password: ${wallet.getPassword()}");
  print("path: ${wallet.getPath()}");
  print("====================================================================");
}

void onSyncingUpdate({
  required int syncHeight,
  required int nodeHeight,
  String? message,
}) {
  print("~~~~~~~~~~ onSyncingUpdate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  Logging.log?.i("message: $message");
  Logging.log?.i("syncingHeight: $syncHeight");
  Logging.log?.i("nodeHeight: $nodeHeight");
  Logging.log?.i("remaining: ${nodeHeight - syncHeight}");
  Logging.log?.i(
      "sync percent: ${(syncHeight / nodeHeight * 100).toStringAsFixed(2)}");
  print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
}
