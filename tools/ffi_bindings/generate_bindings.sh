#!/usr/bin/env bash
cd "$(dirname "$0")"
set -x -e

CURRENT_DIR=$(pwd)

if [[ ! -d "${CURRENT_DIR}/../../build/monero_c" ]];
then
  echo "Missing source needed for bindings generation"
  exit 1
fi

pushd "../../cs_monero"
dart run ffigen --config "${CURRENT_DIR}/monero.yaml"
dart run ffigen --config "${CURRENT_DIR}/wownero.yaml"
popd

echo "FFI bindings generation completed"
