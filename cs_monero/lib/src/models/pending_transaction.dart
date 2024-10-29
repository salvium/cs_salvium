class PendingTransaction {
  PendingTransaction({
    required this.amount,
    required this.fee,
    this.txid,
    this.hex,
    this.pointerAddress,
  });

  final BigInt amount;
  final BigInt fee;
  final String? txid;
  final String? hex;
  final int? pointerAddress;
}
