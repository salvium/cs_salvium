import '../enums/min_confirms.dart';

class Transaction {
  final String displayLabel;
  final String description;
  final BigInt fee;
  final int confirmations;
  final int blockHeight;
  final Set<int> addressIndexes;
  final int accountIndex;
  final String paymentId;
  final BigInt amount;
  final bool isSpend;
  final DateTime timeStamp;
  final String hash;
  final String key;
  final MinConfirms minConfirms;

  bool get isConfirmed => !isPending;
  bool get isPending => confirmations < minConfirms.value;

  Transaction({
    required this.displayLabel,
    required this.description,
    required this.fee,
    required this.confirmations,
    required this.blockHeight,
    required this.accountIndex,
    required this.addressIndexes,
    required this.paymentId,
    required this.amount,
    required this.isSpend,
    required this.hash,
    required this.key,
    required this.timeStamp,
    required this.minConfirms,
  });
}
