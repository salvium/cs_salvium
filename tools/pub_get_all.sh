#!/usr/bin/env bash
cd "$(dirname "$0")"
source env.sh
set -x -e

cd "${PROJECT_DIR}"

pushd compat
  dart pub get
popd

pushd cs_monero
  dart pub get
popd

pushd cs_monero_flutter_libs_platform_interface
  flutter pub get
popd

pushd cs_monero_flutter_libs_android
  flutter pub get
popd

pushd cs_monero_flutter_libs_ios
  flutter pub get
popd

pushd cs_monero_flutter_libs_macos
  flutter pub get
popd

pushd cs_monero_flutter_libs_linux
  flutter pub get
popd

pushd cs_monero_flutter_libs_windows
  flutter pub get
popd

pushd example_app
  flutter pub get
popd
