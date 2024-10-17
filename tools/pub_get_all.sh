#!/usr/bin/env bash
source env.sh
set -x -e

cd "${PROJECT_DIR}"

pushd compat
  dart pub get
popd

pushd cs_monero
  dart pub get
popd

pushd cs_monero_flutter_libs
  flutter pub get
popd

pushd example_app
  flutter pub get
popd
