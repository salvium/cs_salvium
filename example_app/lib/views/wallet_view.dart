import 'package:cs_monero/cs_monero.dart';
import 'package:flutter/material.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key, required this.wallet});

  final Wallet wallet;

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  bool connected = true;
  int outputCount = 0;
  int txCount = 0;
  int balance = 0;
  int unlocked = 0;
  String mnemonic = "";
  Address? address;
  int syncFromHeight = 0;
  int syncHeight = 0;
  int daemonHeight = 0;
  String password = "";
  String path = "";

  Future<void> update() async {
    await widget.wallet.refreshTransactions();
    await widget.wallet.refreshOutputs();
    connected = await widget.wallet.isConnectedToDaemon();
    txCount = widget.wallet.transactionCount();
    outputCount = (await widget.wallet.getOutputs(includeSpent: true)).length;
    path = widget.wallet.getPath();
    password = widget.wallet.getPassword();
    daemonHeight = widget.wallet.getDaemonHeight();
    syncHeight = widget.wallet.syncHeight();
    syncFromHeight = widget.wallet.getSyncFromBlockHeight();
    address = widget.wallet.getAddress();
    mnemonic = widget.wallet.getSeed();
    balance = widget.wallet.getBalance();
    unlocked = widget.wallet.getUnlockedBalance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    (widget.wallet as Polling).addListener(
      WalletListener(
        onSyncingUpdate: ({
          required int syncHeight,
          required int nodeHeight,
          String? message,
        }) {
          setState(() {
            this.syncHeight = syncHeight;
            daemonHeight = nodeHeight;
          });
        },
        onBalancesChanged: ({
          required int newBalance,
          required int newUnlockedBalance,
        }) {
          setState(() {
            balance = newBalance;
            unlocked = newUnlockedBalance;
          });
        },
        onError: (e, s) {
          Logging.log?.e(
            "Wallet Listener onError",
            error: e,
            stackTrace: s,
          );
        },
      ),
    );

    update().then((_) => (widget.wallet as Polling).startListeners());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opened wallet'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.wallet.stopSyncing();
            widget.wallet.close(save: true);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(onPressed: update, child: const Text("Update")),
          TextButton(onPressed: widget.wallet.save, child: const Text("Save")),
        ],
      ),
      body: Column(
        children: [
          Item(kkey: "Connected", value: connected),
          Item(kkey: "outputCount", value: outputCount),
          Item(kkey: "tx count", value: txCount),
          Item(kkey: "mnemonic", value: mnemonic),
          Item(kkey: "path", value: path),
          Item(kkey: "password", value: password),
          Item(kkey: "address", value: address),
          Item(kkey: "balance", value: balance),
          Item(kkey: "unlocked", value: unlocked),
          Item(kkey: "syncFromHeight", value: syncFromHeight),
          Item(kkey: "syncHeight", value: syncHeight),
          Item(kkey: "daemonHeight", value: daemonHeight),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({super.key, this.kkey, this.value});

  final dynamic kkey, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text("$kkey: "),
          SelectableText(value.toString()),
        ],
      ),
    );
  }
}
