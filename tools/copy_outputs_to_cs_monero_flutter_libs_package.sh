#!/usr/bin/env bash
source env.sh
set -x -e

LIBS_PACKAGE_DIR="${PROJECT_DIR}/cs_monero_flutter_libs"

if [[ -d "${OUTPUTS_DIR}/android/jniLibs" ]];
then
  ANDROID_LIBS_DIR="${LIBS_PACKAGE_DIR}/android/src/main/jniLibs"
  rm -rf "${ANDROID_LIBS_DIR}"
  cp -r "${OUTPUTS_DIR}/android/jniLibs" "${ANDROID_LIBS_DIR}"
fi

if [[ -d "${OUTPUTS_DIR}/ios/Frameworks" ]];
then
  IOS_LIBS_DIR="${LIBS_PACKAGE_DIR}/ios/Frameworks"
  rm -rf "${IOS_LIBS_DIR}"
  cp -r "${OUTPUTS_DIR}/ios/Frameworks" "${IOS_LIBS_DIR}"
fi

if [[ -d "${OUTPUTS_DIR}/macos/Frameworks" ]];
then
  MACOS_LIBS_DIR="${LIBS_PACKAGE_DIR}/macos/Frameworks"
  rm -rf "${MACOS_LIBS_DIR}"
  cp -r "${OUTPUTS_DIR}/macos/Frameworks" "${MACOS_LIBS_DIR}"
fi

if [[ -d "${OUTPUTS_DIR}/linux" ]];
then
  LINUX_LIBS_DIR="${LIBS_PACKAGE_DIR}/linux/lib"
  rm -rf "${LINUX_LIBS_DIR}"
  cp -r "${OUTPUTS_DIR}/linux" "${LINUX_LIBS_DIR}"
fi

if [[ -d "${OUTPUTS_DIR}/windows" ]];
then
  WINDOWS_LIBS_DIR="${LIBS_PACKAGE_DIR}/windows/lib"
  rm -rf "${WINDOWS_LIBS_DIR}"
  cp -r "${OUTPUTS_DIR}/windows" "${WINDOWS_LIBS_DIR}"
fi