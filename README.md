## About
Refactored and organized version of flutter_libmonero based on https://github.com/cypherstack/flutter_libmonero/tree/heavy-refactor


## Building monero_c

to do a clean/fresh build, just the delete the top level `build` dir

run the `build_<platform>.sh` script in `tools/build_scripts` to generate the platform specific outputs built and copied to `build/outputs/<platform>`.

to copy the built outputs to the cs_monero_flutter_libs package, run `tools/copy_outputs_to_cs_monero_flutter_libs_package.sh`