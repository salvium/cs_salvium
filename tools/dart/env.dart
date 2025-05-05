import 'dart:io';

const kSalviumCRepo = "https://github.com/cypherstack/salvium_c";
const kSalviumCHash = "136288642fad8c76c67bd0957e654474520b5e65";

final envProjectDir =
    File.fromUri(Platform.script).parent.parent.parent.parent.path;

String get envToolsDir => "$envProjectDir${Platform.pathSeparator}tools";
String get envBuildDir => "$envProjectDir${Platform.pathSeparator}build";
String get envSalviumCDir => "$envBuildDir${Platform.pathSeparator}salvium_c";
String get envOutputsDir =>
    "$envProjectDir${Platform.pathSeparator}built_outputs";
