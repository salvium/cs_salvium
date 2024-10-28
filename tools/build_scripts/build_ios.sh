#!/usr/bin/env bash
cd "$(dirname "$0")"
source ../env.sh
set -x -e

"${TOOLS_DIR}/prepare_monero_c.sh"

for COIN in monero wownero;
do
  pushd "${MONERO_C_DIR}"
    rm -rf external/ios/build
    ./build_single.sh ${COIN} host-apple-ios "-j$(sysctl -n hw.physicalcpu)"
  popd
  unxz -f "${MONERO_C_DIR}/release/${COIN}/host-apple-ios_libwallet2_api_c.dylib.xz"
done

IOS_OUTPUTS_DIR="${OUTPUTS_DIR}/ios/Frameworks"

DYLIB_PATH="${MONERO_C_DIR}/release/monero/host-apple-ios_libwallet2_api_c.dylib"
"${TOOLS_DIR}/create_apple_framework.sh" MoneroWallet "${DYLIB_PATH}" "${IOS_OUTPUTS_DIR}"

DYLIB_PATH="${MONERO_C_DIR}/release/wownero/host-apple-ios_libwallet2_api_c.dylib"
"${TOOLS_DIR}/create_apple_framework.sh" WowneroWallet "${DYLIB_PATH}"  "${IOS_OUTPUTS_DIR}"