#!/usr/bin/env bash


copy_compiled_to_final_locations() {
  if [ "$#" -ne 1 ]; then
    echo "Error: Input dir required"
    return 1
  fi
  OUTPUTS_DIR=$1

  LIBS_PACKAGE_DIR="${PROJECT_DIR}/cs_monero_flutter_libs"

  if [[ -d "${OUTPUTS_DIR}/android/jniLibs" ]];
  then
    ANDROID_LIBS_DIR="${LIBS_PACKAGE_DIR}_android/android/src/main/jniLibs"
    rm -rf "${ANDROID_LIBS_DIR}"
    cp -r "${OUTPUTS_DIR}/android/jniLibs" "${ANDROID_LIBS_DIR}"
  fi

  if [[ -d "${OUTPUTS_DIR}/ios/Frameworks" ]];
  then
    IOS_LIBS_DIR="${LIBS_PACKAGE_DIR}_ios/ios/Frameworks"
    rm -rf "${IOS_LIBS_DIR}"
    cp -r "${OUTPUTS_DIR}/ios/Frameworks" "${IOS_LIBS_DIR}"
  fi

  if [[ -d "${OUTPUTS_DIR}/macos/Frameworks" ]];
  then
    MACOS_LIBS_DIR="${LIBS_PACKAGE_DIR}_macos/macos/Frameworks"
    rm -rf "${MACOS_LIBS_DIR}"
    cp -r "${OUTPUTS_DIR}/macos/Frameworks" "${MACOS_LIBS_DIR}"
  fi

  if [[ -d "${OUTPUTS_DIR}/linux" ]];
  then
    LINUX_LIBS_DIR="${LIBS_PACKAGE_DIR}_linux/linux/lib"
    rm -rf "${LINUX_LIBS_DIR}"
    cp -r "${OUTPUTS_DIR}/linux" "${LINUX_LIBS_DIR}"
  fi

  if [[ -d "${OUTPUTS_DIR}/windows" ]];
  then
    WINDOWS_LIBS_DIR="${LIBS_PACKAGE_DIR}_windows/windows/lib"
    rm -rf "${WINDOWS_LIBS_DIR}"
    cp -r "${OUTPUTS_DIR}/windows" "${WINDOWS_LIBS_DIR}"
  fi
}

