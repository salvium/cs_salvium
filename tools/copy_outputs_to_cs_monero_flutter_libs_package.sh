#!/usr/bin/env bash
cd "$(dirname "$0")"
source env.sh
set -x -e

source shared_functions/copy_to.sh

copy_compiled_to_final_locations "${OUTPUTS_DIR}"
