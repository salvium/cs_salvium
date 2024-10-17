#!/usr/bin/env bash
source env.sh
set -x -e

if [[ ! -d "${MONERO_C_DIR}" ]];
then
  cd "${BUILD_DIR}"
  git clone https://github.com/mrcyjanek/monero_c --branch rewrite-wip
  cd "${MONERO_C_DIR}"
  git checkout "${MONERO_C_HASH}"
  git reset --hard
  git config submodule.libs/wownero.url https://git.cypherstack.com/Cypher_Stack/wownero
  git config submodule.libs/wownero-seed.url https://git.cypherstack.com/Cypher_Stack/wownero-seed
  git submodule update --init --force --recursive
  ./apply_patches.sh monero
  ./apply_patches.sh wownero
  git apply "${TOOLS_DIR}/patches/monero_c_dart_darwin_use_frameworks.patch"
  cd "impls/monero.dart"
  dart pub get
fi