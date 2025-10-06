import 'dart:io';

const kMoneroCRepo = "https://github.com/salvium/monero_c";
const kMoneroCHash = "2b15a840775234e19aad0c183fdab4b0ba1df2df";

final envProjectDir =
    File.fromUri(Platform.script).parent.parent.parent.parent.path;

String get envToolsDir => "$envProjectDir${Platform.pathSeparator}tools";
String get envBuildDir => "$envProjectDir${Platform.pathSeparator}build";
String get envMoneroCDir => "$envBuildDir${Platform.pathSeparator}monero_c";
String get envOutputsDir =>
    "$envProjectDir${Platform.pathSeparator}built_outputs";
