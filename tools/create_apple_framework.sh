#!/usr/bin/env bash
source env.sh
set -x -e

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <framework_name> <dylib> <target_dir>"
  exit 1
fi

FRAMEWORK_NAME=$1
DYLIB_PATH=$2
TARGET_DIR_FRAMEWORKS=$3

mkdir -p "${TARGET_DIR_FRAMEWORKS}/${FRAMEWORK_NAME}.framework"

pushd "${TARGET_DIR_FRAMEWORKS}/${FRAMEWORK_NAME}.framework"
  lipo -create "${DYLIB_PATH}" -output "${FRAMEWORK_NAME}"
  install_name_tool -id "@rpath/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${FRAMEWORK_NAME}"
popd

# create info.plist
PLIST_FILE="${TARGET_DIR_FRAMEWORKS}/${FRAMEWORK_NAME}.framework/Info.plist"

cat << EOF > "${PLIST_FILE}"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>${FRAMEWORK_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.cypherstack.${FRAMEWORK_NAME}</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>${FRAMEWORK_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>FMWK</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
</dict>
</plist>

EOF