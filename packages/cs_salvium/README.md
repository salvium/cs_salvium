<p align="center">
  <a href="https://pub.dev/packages/cs_salvium">
    <img src="https://img.shields.io/pub/v/cs_salvium?label=pub.dev&labelColor=333940&logo=dart">
  </a>
  <a href="https://github.com/invertase/melos">
    <img src="https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square">
  </a>
</p>

# About
- A simplified Flutter/Dart Salvium wallet library.
- Uses https://github.com/MrCyjaneK/monero_c/ for the compiled native libs.
- If you do not trust the binaries hosted on https://pub.dev you can build from
  source. Refer to [`cs_salvium/README.md`](https://github.com/cypherstack/cs_salvium/tree/main/cs_salvium/README.md).

## Quickstart
1. Add to pubspec.yaml
    ```yaml
    dependencies:
      cs_salvium: 0.0.1
      cs_salvium_flutter_libs: 0.0.1 # Contains native libs required by cs_salvium.
    ```
2. Create a wallet
   ```dart
   final wallet = await MoneroWallet.create(
     path: "somePath", // Path to wallet files will be saved,
     password: "SomeSecurePassword", // Your wallet files are only as secure as this password.  This cannot be recovered if lost!
     language: "English", // Seed language.
     seedType: MoneroSeedType.sixteen, // 16 word polyseed or MoneroSeedType.twentyFive for legacy seed format.
     networkType: 0, // Mainnet.
   );

    // Init a connection
    await wallet.connect(
      daemonAddress: "daemonAddress",
      trusted: true,
    );
    
    // get main wallet address for account 0
    final address = wallet.getAddress();
    
    // create a tx
    final pendingTx = await wallet.createTx(
      output: Recipient(
        address: "address",
        amount: BigInt.from(100000000),
      ),
      priority: TransactionPriority.normal,
      accountIndex: 0,
    );
    
    // broadcast/commit tx to network
    await wallet.commitTx(pendingTx);
   ```

## Known Limitations
- No x86_64 iOS simulator (or MacOS) support
- No Android i686 support
