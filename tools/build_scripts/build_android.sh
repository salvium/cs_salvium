#!/usr/bin/env bash
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

unxz -f "${MONERO_C_DIR}/release/monero/x86_64-linux-android_libwallet2_api_c.so.xz"
unxz -f "${MONERO_C_DIR}/release/wownero/x86_64-linux-android_libwallet2_api_c.so.xz"
#unxz -f "${MONERO_C_DIR}/release/monero/i686-linux-android_libwallet2_api_c.so.xz"
#unxz -f "${MONERO_C_DIR}/release/wownero/i686-linux-android_libwallet2_api_c.so.xz"
unxz -f "${MONERO_C_DIR}/release/monero/armv7a-linux-androideabi_libwallet2_api_c.so.xz"
unxz -f "${MONERO_C_DIR}/release/wownero/armv7a-linux-androideabi_libwallet2_api_c.so.xz"
unxz -f "${MONERO_C_DIR}/release/monero/aarch64-linux-android_libwallet2_api_c.so.xz"
unxz -f "${MONERO_C_DIR}/release/wownero/aarch64-linux-android_libwallet2_api_c.so.xz"

JNI_LIBS_OUTPUT_DIR="${OUTPUTS_DIR}/android/jniLibs"

mkdir -p "${JNI_LIBS_OUTPUT_DIR}/x86_64"
#mkdir -p "${JNI_LIBS_OUTPUT_DIR}/i686"
mkdir -p "${JNI_LIBS_OUTPUT_DIR}/armeabi-v7a"
mkdir -p "${JNI_LIBS_OUTPUT_DIR}/arm64-v8a"

cp "${MONERO_C_DIR}/release/monero/x86_64-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/x86_64/libmonero_libwallet2_api_c.so"
cp "${MONERO_C_DIR}/release/wownero/x86_64-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/x86_64/libwownero_libwallet2_api_c.so"
#cp "${MONERO_C_DIR}/release/monero/i686-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/i686/libmonero_libwallet2_api_c.so"
#cp "${MONERO_C_DIR}/release/wownero/i686-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/i686/libwownero_libwallet2_api_c.so"
cp "${MONERO_C_DIR}/release/monero/aarch64-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/arm64-v8a/libmonero_libwallet2_api_c.so"
cp "${MONERO_C_DIR}/release/wownero/aarch64-linux-android_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/arm64-v8a/libwownero_libwallet2_api_c.so"
cp "${MONERO_C_DIR}/release/monero/armv7a-linux-androideabi_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/armeabi-v7a/libmonero_libwallet2_api_c.so"
cp "${MONERO_C_DIR}/release/wownero/armv7a-linux-androideabi_libwallet2_api_c.so" "${JNI_LIBS_OUTPUT_DIR}/armeabi-v7a/libwownero_libwallet2_api_c.so"