#!/usr/bin/env bash
set -e -x

TOOLS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$( realpath "${TOOLS_DIR}/.." )
BUILD_DIR="${TOOLS_DIR}/../build"
MONERO_C_DIR="${BUILD_DIR}/monero_c"
OUTPUTS_DIR="${PROJECT_DIR}/built_outputs"

# If this gets changed, update it in cs_monero/pubspec.yaml as well!
MONERO_C_HASH="d04dcf67ec042fca76b48ffc09ea9d2ea4b5106e"


if [[ ! -d "${BUILD_DIR}" ]];
then
  mkdir -p "${BUILD_DIR}"
fi

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

