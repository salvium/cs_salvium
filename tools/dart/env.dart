import 'dart:io';

const kSalviumCRepo = "https://github.com/cypherstack/salvium_c";
const kSalviumCHash = "d837147a0d6d5cd658c702266b692be44e2e4657";

final envProjectDir =
    File.fromUri(Platform.script).parent.parent.parent.parent.path;

String get envToolsDir => "$envProjectDir${Platform.pathSeparator}tools";
String get envBuildDir => "$envProjectDir${Platform.pathSeparator}build";
String get envSalviumCDir => "$envBuildDir${Platform.pathSeparator}salvium_c";
String get envOutputsDir =>
    "$envProjectDir${Platform.pathSeparator}built_outputs";
