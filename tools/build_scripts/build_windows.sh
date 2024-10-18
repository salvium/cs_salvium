#!/usr/bin/env bash
source ../env.sh
set -x -e

"${TOOLS_DIR}/prepare_monero_c.sh"

MONERO_C_RELEASE_DIR="${MONERO_C_DIR}/release"
WIN_OUTPUTS_DIR="${OUTPUTS_DIR}/windows"
mkdir -p "${WIN_OUTPUTS_DIR}"

pushd "${MONERO_C_DIR}"
  set +e
  command -v sudo && export SUDO=sudo
  set -e
  NPROC="-j$(nproc)"

  for COIN in monero wownero;
  do
    $SUDO ./build_single.sh ${COIN} x86_64-w64-mingw32 "${NPROC}"
    for MAYBE_ARCHIVE in "${MONERO_C_RELEASE_DIR}/${COIN}"/*; do
      if [[ -f "${MAYBE_ARCHIVE}" && "${MAYBE_ARCHIVE}" == *.dll.xz ]]; then
        unxz -f "${MAYBE_ARCHIVE}"
      fi
    done
  done

  # based on the windows cmakelists file from stack wallet...
  cp "${MONERO_C_RELEASE_DIR}/monero/x86_64-w64-mingw32_libwallet2_api_c.dll" "${WIN_OUTPUTS_DIR}/monero_libwallet2_api_c.dll"
  cp "${MONERO_C_RELEASE_DIR}/wownero/x86_64-w64-mingw32_libwallet2_api_c.dll" "${WIN_OUTPUTS_DIR}/wownero_libwallet2_api_c.dll"
  cp "${MONERO_C_RELEASE_DIR}/wownero/x86_64-w64-mingw32_libpolyseed.dll" "${WIN_OUTPUTS_DIR}/libpolyseed.dll"
  cp "${MONERO_C_RELEASE_DIR}/wownero/x86_64-w64-mingw32_libssp-0.dll" "${WIN_OUTPUTS_DIR}/libssp-0.dll"
  cp "${MONERO_C_RELEASE_DIR}/wownero/x86_64-w64-mingw32_libwinpthread-1.dll" "${WIN_OUTPUTS_DIR}/libwinpthread-1.dll"

popd
