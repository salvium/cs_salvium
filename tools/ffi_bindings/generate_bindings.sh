#!/usr/bin/env bash
cd "$(dirname "$0")"
source ../env.sh
set -x -e

if [[ ! -d "${MONERO_C_DIR}" ]];
then
  echo "Missing source needed for bindings generation!"
  exit 1
fi

pushd "${MONERO_C_DIR}"
CHECKED_OUT_HASH="$(git rev-parse HEAD)"
if [ "${CHECKED_OUT_HASH}" != "${MONERO_C_HASH}" ];
then
  echo "Current monero_c hash does not match expected commit!"
  exit 1
fi
popd

pushd "${PROJECT_DIR}/cs_monero"
dart run ffigen --config "${TOOLS_DIR}/ffi_bindings/monero.yaml"
dart run ffigen --config "${TOOLS_DIR}/ffi_bindings/wownero.yaml"
popd

echo "FFI bindings generation completed"
