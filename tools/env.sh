#!/usr/bin/env bash
set -e -x

TOOLS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$( realpath "${TOOLS_DIR}/.." )
BUILD_DIR="${TOOLS_DIR}/../build"
MONERO_C_DIR="${BUILD_DIR}/monero_c"
MONERO_C_HASH="6eb571ea498ed7b854934785f00fabfd0dadf75b"
OUTPUTS_DIR="${BUILD_DIR}/outputs"


if [[ ! -d "${OUTPUTS_DIR}" ]];
then
  mkdir -p "${OUTPUTS_DIR}"
fi


export TOOLS_DIR
export PROJECT_DIR
export BUILD_DIR
export OUTPUTS_DIR
export MONERO_C_DIR
export MONERO_C_HASH

