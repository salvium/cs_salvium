#!/usr/bin/env bash
cd "$(dirname "$0")"
source ../env.sh
set -x -e

"${TOOLS_DIR}/prepare_monero_c.sh"
NPROC_80_PERCENT="-j$(( ($(nproc) * 80 / 100) > 0 ? ($(nproc) * 80 / 100) : 1 ))"

for COIN in monero wownero;
do
  pushd "${MONERO_C_DIR}"
    ./build_single.sh ${COIN} x86_64-linux-android "${NPROC_80_PERCENT}"
    # ./build_single.sh ${COIN} i686-linux-android "${NPROC_80_PERCENT}"
    ./build_single.sh ${COIN} armv7a-linux-androideabi "${NPROC_80_PERCENT}"
    ./build_single.sh ${COIN} aarch64-linux-android "${NPROC_80_PERCENT}"
  popd
done

for COIN in monero wownero;
do
  unxz -f "${MONERO_C_DIR}/release/${COIN}/x86_64-linux-android_libwallet2_api_c.so.xz"
  #unxz -f "${MONERO_C_DIR}/release/${COIN}/i686-linux-android_libwallet2_api_c.so.xz"
  unxz -f "${MONERO_C_DIR}/release/${COIN}/armv7a-linux-androideabi_libwallet2_api_c.so.xz"
  unxz -f "${MONERO_C_DIR}/release/${COIN}/aarch64-linux-android_libwallet2_api_c.so.xz"
done

JNI_LIBS_OUTPUT_DIR="${OUTPUTS_DIR}/android/jniLibs"

mkdir -p "${JNI_LIBS_OUTPUT_DIR}/x86_64"
#mkdir -p "${JNI_LIBS_OUTPUT_DIR}/i686"
mkdir -p "${JNI_LIBS_OUTPUT_DIR}/armeabi-v7a"
mkdir -p "${JNI_LIBS_OUTPUT_DIR}/arm64-v8a"

for COIN in monero wownero;
do
  cp "${MONERO_C_DIR}/release/${COIN}/x86_64-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/x86_64/libmonero_libwallet2_api_c.so"
  #cp "${MONERO_C_DIR}/release/${COIN}/i686-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/i686/libmonero_libwallet2_api_c.so"
  cp "${MONERO_C_DIR}/release/${COIN}/aarch64-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/arm64-v8a/libmonero_libwallet2_api_c.so"
  cp "${MONERO_C_DIR}/release/${COIN}/armv7a-linux-androideabi_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/armeabi-v7a/libmonero_libwallet2_api_c.so"
done
