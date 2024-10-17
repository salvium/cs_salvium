# About
Refactored and organized version of flutter_libmonero based on https://github.com/cypherstack/flutter_libmonero/tree/heavy-refactor

## Usage
#### Option 1
Add this repo as a git submodule, [build](README.md#building-monero_c) the wanted platforms, and finally add `cs_monero`, `cs_monero_flutter_libs`, (and `compat` if needed) to your pubspec.yaml as relative dependencies.

#### Option 2
Coming soon.


## Building monero_c

This repo just has some wrapper scripts. For details and requirements see https://github.com/MrCyjaneK/monero_c/

To do a clean/fresh build, just the delete the top level `build` dir

Run the `build_<platform>.sh` script in `tools/build_scripts` to generate the platform specific outputs built and copied to `build/outputs/<platform>`.

Finally, to copy the built outputs to the cs_monero_flutter_libs package so Flutter will include them, run `tools/copy_outputs_to_cs_monero_flutter_libs_package.sh`
