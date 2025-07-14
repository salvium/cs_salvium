import 'dart:io';
import 'dart:math';

import '../create_framework.dart';
import '../create_ios_xcframework.dart';
import '../env.dart';
import '../util.dart';

void main(List<String> args) async {
  const platforms = ["android", "ios", "macos", "linux", "windows"];
  const coins = ["salvium" /*, "wownero"*/];

  if (args.length != 1) {
    throw ArgumentError(
      "Missing platform argument. Expected one of $platforms",
    );
  }
  final platform = args.first;
  if (!platforms.contains(args.first)) {
    throw ArgumentError(args.first);
  }

  final moneroCDir = Directory(envMoneroCDir);
  if (!moneroCDir.existsSync()) {
    l("Did not find salvium_c. Calling prepare_monero_c.dart...");
    await runAsync(
      "dart",
      [
        "$envToolsDir"
            "${Platform.pathSeparator}dart"
            "${Platform.pathSeparator}bin"
            "${Platform.pathSeparator}prepare_monero_c.dart",
      ],
    );
  }

  final thisDir = Directory.current;
  Directory.current = moneroCDir;

  final nProc = _getNProc(platform);
  final triples = _getTriples(platform);
  final bt = _getBinType(platform);

  for (final triple in triples) {
    for (final coin in coins) {
      await runAsync("./build_single.sh", [coin, triple, "-j$nProc"]);
      final path = "$envMoneroCDir"
          "${Platform.pathSeparator}release"
          "${Platform.pathSeparator}$coin"
          "${Platform.pathSeparator}${triple}_libwallet2_api_c.$bt";
      await runAsync("unxz", ["-f", "$path.xz"]);
    }
  }

  Directory.current = thisDir;

  final builtOutputsDirPath = "$envOutputsDir"
      "${Platform.pathSeparator}$platform";

  // copy to built_outputs as required
  switch (platform) {
    case "android":
      final triples = _getTriples("android");
      final basePath = "$builtOutputsDirPath"
          "${Platform.pathSeparator}jniLibs";

      for (final triple in triples) {
        final mapping = _mapAndroid(triple);
        final dir = Directory(
          "$basePath"
          "${Platform.pathSeparator}$mapping",
        )..createSync(
            recursive: true,
          );
        for (final coin in coins) {
          await runAsync(
            "cp",
            [
              "$envMoneroCDir"
                  "${Platform.pathSeparator}release"
                  "${Platform.pathSeparator}$coin"
                  "${Platform.pathSeparator}${triple}_libwallet2_api_c.so",
              "${dir.path}"
                  "${Platform.pathSeparator}lib${coin}_libwallet2_api_c.so",
            ],
          );
        }
      }

      break;

    case "ios":
      final triples = _getTriples("ios");
      final fwName = "SalviumWallet";

      final dir = Directory(
        "$builtOutputsDirPath"
        "${Platform.pathSeparator}Frameworks",
      )..createSync(
          recursive: true,
        );

      // assume only 2 triples, one of which is simulator
      for (final triple in triples) {
        final salDylib = "$envMoneroCDir"
            "${Platform.pathSeparator}release"
            "${Platform.pathSeparator}salvium"
            "${Platform.pathSeparator}${triple}_libwallet2_api_c.dylib";

        final isSim = triple.endsWith("ios");
        await createIosFramework(
          frameworkName: fwName,
          pathToDylib: salDylib,
          targetDirFrameworks:
              dir.path + Platform.pathSeparator + (isSim ? "sim" : "ios"),
          isSim: isSim,
        );
      }

      await createIosXCFramework(
        dir,
        fwName,
        Directory(
          "${dir.path}"
          "${Platform.pathSeparator}ios"
          "${Platform.pathSeparator}$fwName.framework",
        ),
        Directory(
          "${dir.path}"
          "${Platform.pathSeparator}sim"
          "${Platform.pathSeparator}$fwName.framework",
        ),
      );

      break;

    case "macos":
      final dir = Directory(
        "$builtOutputsDirPath"
        "${Platform.pathSeparator}Frameworks",
      )..createSync(
          recursive: true,
        );

      final String salDylib;
      if (platform == "ios") {
        salDylib = "$envMoneroCDir"
            "${Platform.pathSeparator}release"
            "${Platform.pathSeparator}salvium"
            "${Platform.pathSeparator}aarch64-apple-ios_libwallet2_api_c.dylib";
      } else {
        salDylib = "$envMoneroCDir"
            "${Platform.pathSeparator}release"
            "${Platform.pathSeparator}salvium"
            "${Platform.pathSeparator}aarch64-apple-darwin_libwallet2_api_c.dylib";
      }

      await createFramework(
        frameworkName: "SalviumWallet",
        pathToDylib: salDylib,
        targetDirFrameworks: dir.path,
      );

      break;

    case "linux":
      final dir = Directory(builtOutputsDirPath)
        ..createSync(
          recursive: true,
        );
      for (final coin in coins) {
        await runAsync(
          "cp",
          [
            "$envMoneroCDir"
                "${Platform.pathSeparator}release"
                "${Platform.pathSeparator}$coin"
                "${Platform.pathSeparator}x86_64-linux-gnu_libwallet2_api_c.so",
            "${dir.path}"
                "${Platform.pathSeparator}${coin}_libwallet2_api_c.so",
          ],
        );
      }
      break;

    case "windows":
      final dir = Directory(builtOutputsDirPath)
        ..createSync(
          recursive: true,
        );
      await runAsync(
        "cp",
        [
          "$envMoneroCDir"
              "${Platform.pathSeparator}release"
              "${Platform.pathSeparator}salvium"
              "${Platform.pathSeparator}x86_64-w64-mingw32_libwallet2_api_c.dll",
          "${dir.path}"
              "${Platform.pathSeparator}salvium_libwallet2_api_c.dll",
        ],
      );

    default:
      throw Exception("Not sure how you got this far tbh");
  }
}

String _mapAndroid(String triple) {
  switch (triple) {
    case "x86_64-linux-android":
      return "x86_64";
    case "aarch64-linux-android":
      return "arm64-v8a";
    case "armv7a-linux-androideabi":
      return "armeabi-v7a";
    default:
      throw ArgumentError("Unsupported triple: $triple");
  }
}

List<String> _getTriples(String platform) {
  switch (platform) {
    case "android":
      return [
        "x86_64-linux-android",
        "armv7a-linux-androideabi",
        "aarch64-linux-android",
      ];

    case "ios":
      return ["aarch64-apple-ios", "aarch64-apple-iossimulator"];

    case "macos":
      return ["aarch64-apple-darwin"];

    case "linux":
      return ["x86_64-linux-gnu"];

    case "windows":
      return ["x86_64-w64-mingw32"];

    default:
      throw ArgumentError(platform, "platform");
  }
}

String _getNProc(String platform) {
  final int nProc;
  if (platform == "ios" || platform == "macos") {
    final result = Process.runSync("sysctl", ["-n", "hw.physicalcpu"]);
    if (result.exitCode != 0) {
      throw Exception("code=${result.exitCode}, stderr=${result.stderr}");
    }
    nProc = int.parse(result.stdout.toString());
  } else {
    final result = Process.runSync("nproc", []);
    if (result.exitCode != 0) {
      throw Exception("code=${result.exitCode}, stderr=${result.stderr}");
    }
    nProc = int.parse(result.stdout.toString());
  }

  switch (platform) {
    case "android":
    case "linux":
      return max(1, (nProc * 0.8).floor()).toString();

    case "ios":
    case "macos":
    case "windows":
      return nProc.toString();

    default:
      throw ArgumentError(platform, "platform");
  }
}

String _getBinType(String platform) {
  switch (platform) {
    case "android":
    case "linux":
      return "so";

    case "windows":
      return "dll";

    case "ios":
    case "macos":
      return "dylib";

    default:
      throw ArgumentError(platform, "platform");
  }
}
