#!/bin/sh

if [[ ${target_platform} == "linux-ppc64le" || ${target_platform} == "linux-aarch64" ]]; then
    alias ninja='`which ninja` -j1'
fi

python -m pip install . -vv
