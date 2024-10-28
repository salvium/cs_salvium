#!/usr/bin/env bash
cd "$(dirname "$0")"
source env.sh
set -x -e

if [[ ! -d "${MONERO_C_DIR}" ]];
then
  cd "${BUILD_DIR}"
  git clone https://github.com/cypherstack/monero_c --branch apple-frameworks
  cd "${MONERO_C_DIR}"
  git checkout "${MONERO_C_HASH}"
  git reset --hard
  git config submodule.libs/wownero.url https://git.cypherstack.com/Cypher_Stack/wownero
  git config submodule.libs/wownero-seed.url https://git.cypherstack.com/Cypher_Stack/wownero-seed
  git submodule update --init --force --recursive
  ./apply_patches.sh monero
  ./apply_patches.sh wownero
  cd "impls/monero.dart"
  dart pub get
fi