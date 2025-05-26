import 'package:cs_salvium/cs_salvium.dart';
import 'package:test/test.dart';

void main() {
  group("$MinConfirms", () {
    test("contains two values", () {
      expect(MinConfirms.values.length, 1);
    });

    test("each confirmation type has the correct associated value", () {
      expect(MinConfirms.salvium.value, 10);
    });

    test("values are accessible by index", () {
      expect(MinConfirms.values[0], MinConfirms.salvium);
    });

    test("toString returns correct value", () {
      expect(MinConfirms.salvium.toString(), "MinConfirms.salvium");
    });
  });
}
