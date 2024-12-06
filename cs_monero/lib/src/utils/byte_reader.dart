/// A bytes reader used for deserializing transactions from hex.
class ByteReader {
  final List<int> _bytes;
  int position = 0;

  ByteReader(this._bytes);

  bool get isEOF => position >= _bytes.length;

  int get bytesRemaining => _bytes.length - position;

  int readByte() {
    if (isEOF) {
      throw Exception('Attempted to read beyond EOF');
    }
    final byte = _bytes[position];
    position++;
    // Debugging log:
    // print(
    //     '[ByteReader] Read byte: ${byte.toRadixString(16).padLeft(2, '0')} pos=$position/${_bytes.length}');
    return byte;
  }

  List<int> readBytes(int length) {
    if (position + length > _bytes.length) {
      throw Exception(
          'Attempt to read $length bytes but only ${_bytes.length - position} bytes remaining');
    }
    final sublist = _bytes.sublist(position, position + length);
    position += length;
    // print(
    //     '[ByteReader] Read $length bytes: ${_bytesToHex(sublist)} pos=$position/${_bytes.length}');
    return sublist;
  }

  BigInt readVarInt() {
    final value = _readVarIntInternal();
    // print(
    //     '[ByteReader] Read varint: $value (decimal), bytesRemaining: $bytesRemaining');
    return value;
  }

  // Helper for varint.
  BigInt _readVarIntInternal() {
    var shift = 0;
    var value = BigInt.zero;

    while (true) {
      final b = readByte();
      value |= BigInt.from(b & 0x7f) << shift;
      shift += 7;
      if ((b & 0x80) == 0) break;
    }

    return value;
  }

  int peekByte() {
    if (isEOF) {
      throw Exception('Attempted to peek at EOF');
    }
    return _bytes[position];
  }
}
