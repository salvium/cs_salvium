import 'dart:io';

const kMoneroCRepo = "https://github.com/cypherstack/salvium_c";
const kMoneroCHash = "3201cf95595e41a2243bc52713abf1bf7a4317ce";

final envProjectDir =
    File.fromUri(Platform.script).parent.parent.parent.parent.path;

String get envToolsDir => "$envProjectDir${Platform.pathSeparator}tools";
String get envBuildDir => "$envProjectDir${Platform.pathSeparator}build";
String get envMoneroCDir => "$envBuildDir${Platform.pathSeparator}salvium_c";
String get envOutputsDir =>
    "$envProjectDir${Platform.pathSeparator}built_outputs";
