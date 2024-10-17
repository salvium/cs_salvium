#!/usr/bin/env bash
source ../env.sh
set -x -e

"${TOOLS_DIR}/prepare_monero_c.sh"

for COIN in monero wownero;
do
  pushd "${MONERO_C_DIR}"
    ./build_single.sh ${COIN} host-apple-darwin "-j$(sysctl -n hw.physicalcpu)"
  popd
  unxz -f "${MONERO_C_DIR}/release/${COIN}/host-apple-darwin_libwallet2_api_c.dylib.xz"
done

MACOS_OUTPUTS_DIR="${OUTPUTS_DIR}/macos/Frameworks"

DYLIB_PATH="${MONERO_C_DIR}/release/monero/host-apple-darwin_libwallet2_api_c.dylib"
"${TOOLS_DIR}/create_apple_framework.sh" MoneroWallet "${DYLIB_PATH}" "${MACOS_OUTPUTS_DIR}"

DYLIB_PATH="${MONERO_C_DIR}/release/wownero/host-apple-darwin_libwallet2_api_c.dylib"
"${TOOLS_DIR}/create_apple_framework.sh" WowneroWallet "${DYLIB_PATH}"  "${MACOS_OUTPUTS_DIR}"