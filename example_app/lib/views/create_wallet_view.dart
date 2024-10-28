import 'package:cs_monero/cs_monero.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class CreateWalletView extends StatefulWidget {
  const CreateWalletView({super.key});

  @override
  State<CreateWalletView> createState() => _CreateWalletViewState();
}

class _CreateWalletViewState extends State<CreateWalletView> {
  final nameController = TextEditingController();
  final pwController = TextEditingController();

  String _type = "monero";
  bool _locked = false;

  Future<Wallet> createWallet(String type, String name, String password) async {
    final existing = await loadWalletNames(type);
    if (existing.contains(name)) {
      throw Exception("Wallet with name: \"$name\" already exists");
    }

    final path = await pathForWallet(name: name, type: type);

    final Wallet wallet;
    switch (type) {
      case "monero":
        wallet = await MoneroWallet.create(
          path: path,
          password: password,
          seedType: MoneroSeedType.sixteen,
        );
        break;

      case "wownero":
        wallet = await WowneroWallet.create(
          path: path,
          password: password,
          seedType: WowneroSeedType.twentyFive,
        );
        break;

      default:
        throw Exception("Unknown wallet type: $type");
    }

    return wallet;
  }

  Future<void> _onPressed() async {
    if (_locked) return;
    setState(() {
      _locked = true;
    });

    try {
      final wallet = await createWallet(
        _type,
        nameController.text,
        pwController.text,
      );

      if (mounted) {
        await showAdaptiveDialog<void>(
          context: context,
          builder: (_) => AlertDialog.adaptive(
            title: const Text("Success!"),
            content: Text("${nameController.text} created."),
          ),
        );
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
  void dispose() {
    nameController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create wallet'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: "monero",
                  label: Text("Monero"),
                ),
                ButtonSegment<String>(
                  value: "wownero",
                  label: Text("Wownero"),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _type = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pwController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: _locked ? null : _onPressed,
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
