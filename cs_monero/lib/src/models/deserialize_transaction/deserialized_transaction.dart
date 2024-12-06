import 'dart:math' as math;

import '../../utils/byte_reader.dart';
import 'tx_extra.dart';
import 'tx_input.dart';
import 'tx_output.dart';

class DeserializedTransaction {
  final BigInt version;
  final BigInt unlockTime;
  final List<TxInput> vin;
  final List<TxOutput> vout;
  final List<int> extra;
  final List<TxExtraField> extraFields;
  final List<int> remainingBytes;

  DeserializedTransaction({
    required this.version,
    required this.unlockTime,
    required this.vin,
    required this.vout,
    required this.extra,
    required this.extraFields,
    required this.remainingBytes,
  });

  factory DeserializedTransaction.deserialize(String hexTransaction) {
    final bytes = _hexToBytes(hexTransaction);
    final reader = ByteReader(bytes);

    // print('Total bytes: ${bytes.length}');

    // Helper function for hex display
    String bytesToHex(List<int> bytes) {
      return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
    }

    // Read version.
    // print('\n=== Reading Version ===');
    // print(
    //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 10, bytes.length)))}');
    final version = reader.readVarInt();
    // print('Version: $version');

    // Read unlock time.
    // print('\n=== Reading Unlock Time ===');
    // print(
    //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 10, bytes.length)))}');
    final unlockTime = reader.readVarInt();
    // print('Unlock time: $unlockTime');

    // Read inputs.
    // print('\n=== Reading Inputs ===');
    // print(
    //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 10, bytes.length)))}');
    final vinCount = reader.readVarInt().toInt();
    // print('Input count: $vinCount');

    final vin = <TxInput>[];
    for (var i = 0; i < vinCount; i++) {
      // print('\nReading input $i');
      // print(
      //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 50, bytes.length)))}');
      final input = TxInput.fromReader(reader);
      if (input is TxinToKey) {
        // print(
        //     'Input $i: TxinToKey with ${input.keyOffsets.length} key offsets');
      }
      vin.add(input);
    }

    // Read outputs.
    // print('\n=== Reading Outputs ===');
    // print(
    //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 10, bytes.length)))}');
    final voutCount = reader.readVarInt().toInt();
    // print('Output count: $voutCount');

    final vout = <TxOutput>[];
    for (var i = 0; i < voutCount; i++) {
      // print('\nReading output $i');
      // print(
      //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 50, bytes.length)))}');
      final output = TxOutput.fromReader(reader);
      // print('Output $i: amount=${output.amount}');
      vout.add(output);
    }

    // Read extra field
    // print('\n=== Reading Extra Field ===');
    // print(
    //     'Position: ${reader.position}, Next bytes: ${bytesToHex(bytes.sublist(reader.position, math.min(reader.position + 10, bytes.length)))}');

    // Instead of reading a varint for the extra size, we'll try to parse the
    // extra field directly.  Read the next few bytes and parse them as extras:
    final extraStartPos = reader.position;
    final maxExtraSize =
        math.min(100, reader.bytesRemaining); // Limit extra field size
    final extra = reader.readBytes(maxExtraSize);

    List<TxExtraField> extraFields;
    try {
      extraFields = parseExtraField(extra);
      // print('Successfully parsed ${extraFields.length} extra fields');
    } catch (e) {
      // print('Error parsing extra fields: $e');
      extraFields = [];
    }

    // Capture remaining bytes (containing the ring signature).
    final remainingBytes = bytes.sublist(reader.position);
    // print('\nRemaining bytes length: ${remainingBytes.length}');

    return DeserializedTransaction(
      version: version,
      unlockTime: unlockTime,
      vin: vin,
      vout: vout,
      extra: extra,
      extraFields: extraFields,
      remainingBytes: remainingBytes,
    );
  }
}

List<int> _hexToBytes(String hex) {
  if (hex.length % 2 != 0) {
    throw ArgumentError('Hex string must have an even length');
  }
  final result = <int>[];
  for (var i = 0; i < hex.length; i += 2) {
    result.add(int.parse(hex.substring(i, i + 2), radix: 16));
  }
  return result;
}
