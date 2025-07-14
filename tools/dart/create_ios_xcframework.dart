import 'dart:io';

import 'util.dart';

Future<void> createIosFramework({
  required String frameworkName,
  required String pathToDylib,
  required String targetDirFrameworks,
  required bool isSim,
}) async {
  // Create the framework directory
  final frameworkDir = Directory(
    "$targetDirFrameworks"
    "${Platform.pathSeparator}$frameworkName.framework",
  );

  await deleteIfExists(frameworkDir.parent.path);

  await frameworkDir.create(recursive: true);

  // Change directory to the framework directory and run commands
  final temp = Directory.current;
  Directory.current = frameworkDir;
  await runAsync(
    "lipo",
    [
      "-create",
      pathToDylib,
      "-output",
      "${frameworkDir.path}"
          "${Platform.pathSeparator}$frameworkName",
    ],
  );
  await runAsync("install_name_tool", [
    "-id",
    "@rpath"
        "${Platform.pathSeparator}$frameworkName.framework"
        "${Platform.pathSeparator}$frameworkName",
    "${frameworkDir.path}"
        "${Platform.pathSeparator}$frameworkName",
  ]);
  Directory.current = temp;

  // Create Info.plist file
  final plistFile = File(
    "${frameworkDir.path}"
    "${Platform.pathSeparator}Info.plist",
  );

  final String platform;
  if (frameworkName.endsWith("Sim")) {
    platform = "iPhoneSimulator";
  } else {
    platform = "iPhoneOS";
  }

  await plistFile.writeAsString('''
<plist version="1.0">
    <dict>
        <key>BuildMachineOSBuild</key>
        <string>23E224</string>
        <key>CFBundleDevelopmentRegion</key>
        <string>en</string>
        <key>CFBundleExecutable</key>
        <string>$frameworkName</string>
        <key>CFBundleIdentifier</key>
        <string>com.cypherstack.$frameworkName</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleName</key>
        <string>$frameworkName</string>
        <key>CFBundlePackageType</key>
        <string>FMWK</string>
        <key>CFBundleShortVersionString</key>
        <string>1.0</string>
        <key>CFBundleSupportedPlatforms</key>
        <array>
            <string>$platform</string>
        </array>
        <key>CFBundleVersion</key>
        <string>1.0.0</string>
        <key>MinimumOSVersion</key>
        <string>15.0</string>
        <key>UIDeviceFamily</key>
        <array>
            <integer>1</integer>
            <integer>2</integer>
        </array>
        <key>UIRequiredDeviceCapabilities</key>
        <array>
            <string>arm64</string>
        </array>
    </dict>
</plist>
''');
}

Future<void> createIosXCFramework(
  Directory xcDir,
  String frameworkName,
  Directory framework,
  Directory simFramework,
) async {
  final xcDirPath = "${xcDir.path}"
      "${Platform.pathSeparator}$frameworkName.xcframework";

  await deleteIfExists(xcDirPath);

  await runAsync('xcodebuild', [
    '-create-xcframework',
    '-framework',
    framework.path,
    '-framework',
    simFramework.path,
    '-output',
    xcDirPath,
  ]);

  await deleteIfExists(framework.parent.path);
  await deleteIfExists(simFramework.parent.path);

  l("XCFramework $frameworkName created successfully in $xcDirPath");
}

Future<void> deleteIfExists(String path) async {
  final entity = FileSystemEntity.typeSync(path);
  if (entity != FileSystemEntityType.notFound) {
    await Directory(path).delete(recursive: true).catchError((_) {
      return File(path).delete();
    });
  }
}
