#!/usr/bin/env bash
source ../env.sh
set -x -e

"${TOOLS_DIR}/prepare_monero_c.sh"

pushd "${MONERO_C_DIR}"
  set +e
  command -v sudo && export SUDO=sudo
  set -e
  NPROC="-j$(nproc)"

  for COIN in monero wownero;
  do
    $SUDO ./build_single.sh ${COIN} x86_64-w64-mingw32 "${NPROC}"
    unxz -f "${MONERO_C_DIR}/release/${COIN}/*.dll.xz"
    mkdir -p "${OUTPUTS_DIR}/windows"
    cp "${MONERO_C_DIR}/release/${COIN}/*.dll" "${OUTPUTS_DIR}/windows/"
  done
popd
