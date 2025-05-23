import 'salvium//chinese_simplified.dart';
import 'salvium/dutch.dart';
import 'salvium/english.dart' as salvium;
import 'salvium/french.dart';
import 'salvium/german.dart';
import 'salvium/italian.dart';
import 'salvium/japanese.dart';
import 'salvium/portuguese.dart';
import 'salvium/russian.dart';
import 'salvium/spanish.dart';

List<String> getSalviumWordList(String language) {
  switch (language.toLowerCase()) {
    case 'english':
      return salvium.EnglishMnemonics.words;
    case 'chinese (simplified)':
      return ChineseSimplifiedMnemonics.words;
    case 'dutch':
      return DutchMnemonics.words;
    case 'german':
      return GermanMnemonics.words;
    case 'japanese':
      return JapaneseMnemonics.words;
    case 'portuguese':
      return PortugueseMnemonics.words;
    case 'russian':
      return RussianMnemonics.words;
    case 'spanish':
      return SpanishMnemonics.words;
    case 'french':
      return FrenchMnemonics.words;
    case 'italian':
      return ItalianMnemonics.words;
    default:
      return salvium.EnglishMnemonics.words;
  }
}
