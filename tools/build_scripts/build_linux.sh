#!/usr/bin/env bash
source ../env.sh
set -x -e

"${TOOLS_DIR}/prepare_monero_c.sh"

LINUX_OUTPUTS_DIR="${OUTPUTS_DIR}/linux"
NPROC_80_PERCENT="-j$(( ($(nproc) * 80 / 100) > 0 ? ($(nproc) * 80 / 100) : 1 ))"

mkdir -p "${LINUX_OUTPUTS_DIR}"

for COIN in monero wownero;
do
  pushd "${MONERO_C_DIR}"
    ./build_single.sh ${COIN} x86_64-linux-gnu  "${NPROC_80_PERCENT}"
  popd
  unxz -f "${MONERO_C_DIR}/release/${COIN}/x86_64-linux-gnu_libwallet2_api_c.so.xz"
  cp "${MONERO_C_DIR}/release/${COIN}/x86_64-linux-gnu_libwallet2_api_c.so" "${LINUX_OUTPUTS_DIR}/${COIN}_libwallet2_api_c.so"
done
