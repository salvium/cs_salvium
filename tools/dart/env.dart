import 'dart:io';

const kMoneroCRepo = "https://github.com/salvium/monero_c";
const kMoneroCHash = "7f3144409c97c2a559b884f9fb070e53b03f8374";

final envProjectDir =
    File.fromUri(Platform.script).parent.parent.parent.parent.path;

String get envToolsDir => "$envProjectDir${Platform.pathSeparator}tools";
String get envBuildDir => "$envProjectDir${Platform.pathSeparator}build";
String get envMoneroCDir => "$envBuildDir${Platform.pathSeparator}monero_c";
String get envOutputsDir =>
    "$envProjectDir${Platform.pathSeparator}built_outputs";
