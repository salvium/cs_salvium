import 'package:cs_monero/cs_monero.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'wallet_view.dart';

class OpenWalletView extends StatefulWidget {
  const OpenWalletView({super.key});

  @override
  State<OpenWalletView> createState() => _OpenWalletViewState();
}

class _OpenWalletViewState extends State<OpenWalletView> {
  final Map<String, TextEditingController> _controllers = {};

  int? selectedIndex;
  bool _locked = false;

  Future<List<String>> getAll() async {
    final monero = await loadWalletNames("monero");
    final wownero = await loadWalletNames("wownero");

    return monero.map((e) => "Monero:  $e").toList()
      ..addAll(
        wownero.map((e) => "Wownero: $e"),
      );
  }

  Future<void> _onPressed(String type, String name, String pw) async {
    if (_locked) return;
    setState(() {
      _locked = true;
    });

    try {
      final path = await pathForWallet(name: name, type: type);
      final Wallet wallet;
      final String daemonAddress;
      switch (type) {
        case "monero":
          daemonAddress = "monero.stackwallet.com:18081";
          wallet = MoneroWallet.loadWallet(
            path: path,
            password: pw,
          );
          break;

        case "wownero":
          daemonAddress = "eu-west-2.wow.xmr.pm:34568";
          wallet = WowneroWallet.loadWallet(
            path: path,
            password: pw,
          );
          break;

        default:
          throw Exception("Unknown wallet type: $type");
      }
      final success = await wallet.connect(
        daemonAddress: daemonAddress,
        trusted: true,
        useSSL: true,
      );

      wallet.startSyncing();

      if (mounted) {
        if (success) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WalletView(
                wallet: wallet,
              ),
            ),
          );
        } else {
          await showAdaptiveDialog<void>(
            context: context,
            builder: (_) => const AlertDialog.adaptive(
              title: Text("Failed to connect"),
            ),
          );
        }
      }
    } catch (e, s) {
      if (mounted) {
        await showAdaptiveDialog<void>(
          context: context,
          builder: (_) => AlertDialog.adaptive(
            title: Text(e.toString()),
            content: Text(s.toString()),
          ),
        );
      }
    } finally {
      setState(() {
        _locked = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAll().then((all) {
      setState(() {
        names = all;
      });
    });
  }

  @override
  void dispose() {
    for (final e in _controllers.values) {
      e.dispose;
    }
    super.dispose();
  }

  List<String>? names;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open wallet'),
        centerTitle: true,
      ),
      body: names == null
          ? const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            )
          : names!.isEmpty
              ? const Center(
                  child: Text("No wallets found"),
                )
              : ListView.builder(
                  itemCount: names!.length,
                  itemBuilder: (context, index) {
                    _controllers[names![index]] ??= TextEditingController();
                    return ListTile(
                      title: Row(
                        children: [
                          Text(names![index]),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: TextField(
                              controller: _controllers[names![index]],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      leading: Radio<int>(
                        value: index,
                        groupValue: selectedIndex,
                        onChanged: (int? value) {
                          setState(() {
                            selectedIndex = value;
                          });
                        },
                      ),
                      trailing: TextButton(
                        onPressed: selectedIndex != index
                            ? null
                            : () {
                                final actualName = names![index].substring(9);
                                final String type;
                                if (names![index].startsWith("Mon")) {
                                  type = "monero";
                                } else {
                                  type = "wownero";
                                }

                                _onPressed(
                                  type,
                                  actualName,
                                  _controllers[names![index]]!.text,
                                );
                              },
                        child: const Text("Open"),
                      ),
                    );
                  },
                ),
    );
  }
}
