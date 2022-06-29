#!/bin/sh

if [[ ${target_platform} == "linux-ppc64le" || ${target_platform} == "linux-aarch64" ]]; then
    export CMAKE_BUILD_PARALLEL_LEVEL=1
fi

python -m pip install . -vv
