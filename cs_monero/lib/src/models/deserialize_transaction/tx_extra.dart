import '../../utils/byte_reader.dart';

abstract class TxExtraField {}

class TxExtraPubKey extends TxExtraField {
  final List<int> pubKey;
  TxExtraPubKey(this.pubKey);
}

class TxExtraNonce extends TxExtraField {
  final List<int> nonce;
  TxExtraNonce(this.nonce);
}

class TxExtraAdditionalPubKeys extends TxExtraField {
  final List<List<int>> pubKeys;
  TxExtraAdditionalPubKeys(this.pubKeys);
}

List<TxExtraField> parseExtraField(List<int> extra) {
  final reader = ByteReader(extra);
  final fields = <TxExtraField>[];

  while (!reader.isEOF) {
    // Check we can read at least one byte for the tag.
    if (reader.bytesRemaining < 1) {
      break; // No more data.
    }

    final tag = reader.readByte();

    switch (tag) {
      case 0x00: // Padding.
        // Skip any subsequent 0x00 bytes.
        while (!reader.isEOF && reader.peekByte() == 0x00) {
          reader.readByte();
        }
        break;
      case 0x01: // tx_extra_pub_key.
        // Ensure we have 32 bytes available for pubKey.
        if (reader.bytesRemaining < 32) {
          // Not enough data left, abort parsing.
          return fields;
        }
        final pubKey = reader.readBytes(32);
        fields.add(TxExtraPubKey(pubKey));
        break;
      case 0x02: // tx_extra_nonce
        // First read length byte.
        if (reader.bytesRemaining < 1) {
          return fields; // Truncated nonce length.
        }
        final length = reader.readByte();
        if (reader.bytesRemaining < length) {
          return fields; // Not enough data for nonce.
        }
        final nonce = reader.readBytes(length);
        fields.add(TxExtraNonce(nonce));
        break;
      case 0x04: // tx_extra_additional_pub_keys.
        if (reader.bytesRemaining < 1) {
          return fields; // No length byte.
        }
        final length = reader.readByte();
        // Length should be a multiple of 32.
        if (length % 32 != 0 || reader.bytesRemaining < length) {
          return fields; // Malformed or incomplete data.
        }

        final count = length ~/ 32;
        final pubKeys = <List<int>>[];
        for (var i = 0; i < count; i++) {
          pubKeys.add(reader.readBytes(32));
        }
        fields.add(TxExtraAdditionalPubKeys(pubKeys));
        break;
      default:
        // Unknown tag encountered. We cannot parse further safely.
        return fields;
    }
  }

  return fields;
}
