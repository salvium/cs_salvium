import 'dart:io';

import 'env.dart';

/// run a system process
Future<void> runAsync(String command, List<String> arguments) async {
  final process = await Process.start(command, arguments);

  process.stdout.transform(SystemEncoding().decoder).listen((data) {
    l('[stdout]: $data');
  });

  process.stderr.transform(SystemEncoding().decoder).listen((data) {
    l('[stderr]: $data');
  });

  // Wait for the process to complete
  final exitCode = await process.exitCode;

  if (exitCode != 0) {
    l("$command exited with code $exitCode");
    exit(exitCode);
  }
}

/// create some build dirs if they don't already exist
Future<void> createBuildDirs() async {
  await Future.wait([
    Directory(envBuildDir).create(recursive: true),
    Directory(envOutputsDir).create(recursive: true),
  ]);
}

/// extremely basic logger
void l(Object? o) {
  // ignore: avoid_print
  print(o);
}
