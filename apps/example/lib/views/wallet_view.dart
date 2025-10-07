import 'package:cs_salvium/cs_salvium.dart';
import 'package:flutter/material.dart';

import '../app_config.dart';
import '../widgets/info_item.dart';
import 'create_transaction_view.dart';
import 'create_stake_view.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key, required this.wallet});

  final Wallet wallet;

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  bool isViewOnly = false;
  bool connected = true;
  int outputCount = 0;
  int txCount = 0;
  BigInt balance = BigInt.zero;
  BigInt unlocked = BigInt.zero;
  String mnemonic = "";
  Address? address;
  int syncFromHeight = 0;
  int syncHeight = 0;
  int daemonHeight = 0;
  String password = "";
  String path = "";

  String publicViewKey = "";
  String privateViewKey = "";
  String publicSpendKey = "";
  String privateSpendKey = "";

  Future<void> update() async {
    isViewOnly = widget.wallet.isViewOnly();
    connected = await widget.wallet.isConnectedToDaemon();
    txCount = (await widget.wallet.getAllTxids(refresh: true)).length;
    outputCount =
        (await widget.wallet.getOutputs(includeSpent: true, refresh: true))
            .length;
    path = widget.wallet.getPath();
    password = widget.wallet.getPassword();
    daemonHeight = widget.wallet.getDaemonHeight();
    syncHeight = widget.wallet.getCurrentWalletSyncingHeight();
    syncFromHeight = widget.wallet.getRefreshFromBlockHeight();
    address = widget.wallet.getAddress();
    mnemonic = widget.wallet.getSeed();
    balance = widget.wallet.getBalance();
    unlocked = widget.wallet.getUnlockedBalance();
    publicViewKey = widget.wallet.getPublicViewKey();
    privateViewKey = widget.wallet.getPrivateViewKey();
    publicSpendKey = widget.wallet.getPublicSpendKey();
    privateSpendKey = widget.wallet.getPrivateSpendKey();

    if (mounted) {
      setState(() {});
    }
  }

  // Future<void> doThing() async {
  //   final other = widget.wallet.getBalance(accountIndex: 2);
  //   print(other);
  // }

  @override
  void initState() {
    super.initState();

    widget.wallet.addListener(
      WalletListener(
        onSyncingUpdate: ({
          required int syncHeight,
          required int nodeHeight,
          String? message,
        }) {
          if (mounted) {
            setState(() {
              this.syncHeight = syncHeight;
              daemonHeight = nodeHeight;
            });
          }
        },
        onBalancesChanged: ({
          required BigInt newBalance,
          required BigInt newUnlockedBalance,
        }) {
          if (mounted) {
            setState(() {
              balance = newBalance;
              unlocked = newUnlockedBalance;
            });
          }
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

    update().then((_) => widget.wallet.startListeners());
  }

  final syncHeightController = TextEditingController();

  @override
  void dispose() {
    syncHeightController.dispose();
    super.dispose();
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
          TextButton(
            onPressed: widget.wallet.rescanBlockchain,
            child: const Text("Rescan"),
          ),
          TextButton(onPressed: update, child: const Text("Update")),
          // TextButton(onPressed: doThing, child: const Text("doThing")),
          TextButton(onPressed: widget.wallet.save, child: const Text("Save")),
        ],
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (context) => CreateTransactionView(
                    wallet: widget.wallet,
                  ),
                ),
              );
            },
            child: const Text("Send"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (context) => CreateStakeView(
                    wallet: widget.wallet,
                  ),
                ),
              );
            },
            child: const Text("Stake"),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Sync from height',
                    ),
                    controller: syncHeightController,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final height = int.tryParse(syncHeightController.text);

                    if (height is int) {
                      widget.wallet.setRefreshFromBlockHeight(height);
                    }
                  },
                  child: const Text("Attempt apply"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                InfoItem(label: "Network Type", value: AppConfig.modeString),
                InfoItem(label: "Is view only", value: isViewOnly),
                InfoItem(label: "Connected", value: connected),
                InfoItem(label: "outputCount", value: outputCount),
                InfoItem(label: "tx count", value: txCount),
                InfoItem(label: "mnemonic", value: mnemonic),
                InfoItem(label: "path", value: path),
                InfoItem(label: "password", value: password),
                InfoItem(label: "address", value: address),
                InfoItem(label: "balance", value: balance),
                InfoItem(label: "unlocked", value: unlocked),
                InfoItem(label: "syncFromHeight", value: syncFromHeight),
                InfoItem(label: "syncHeight", value: syncHeight),
                InfoItem(label: "daemonHeight", value: daemonHeight),
                InfoItem(label: "publicViewKey", value: publicViewKey),
                InfoItem(label: "privateViewKey", value: privateViewKey),
                InfoItem(label: "publicSpendKey", value: publicSpendKey),
                InfoItem(label: "privateSpendKey", value: privateSpendKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
