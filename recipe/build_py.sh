#!/bin/sh

export SETUPTOOLS_SCM_PRETEND_VERSION="$PKG_VERSION"
python -m pip install --no-build-isolation --no-deps . -vv
