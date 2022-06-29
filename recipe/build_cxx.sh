#!/bin/sh

if [[ ${target_platform} == "linux-ppc64le" || ${target_platform} == "linux-aarch64" ]]; then
  export BUILD_EXAMPLES=OFF
else
  export BUILD_EXAMPLES=ON
fi

mkdir build
cd build

cmake -GNinja .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_TESTING=OFF \
      -DBUILD_EXAMPLES=${BUILD_EXAMPLES} \
      -DUSE_SYSTEM_WIDE_TL_OPTIONAL=ON

cmake --build . --config Release
cmake --build . --config Release --target install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  # Test suppressed as a workaround for https://github.com/conda-forge/staged-recipes/pull/14142#issuecomment-789047770
  # and https://github.com/conda-forge/manif-feedstock/pull/1#issuecomment-861226265
  ctest --output-on-failure -C Release -E "gtest_se2_tangent|gtest_se2_tangent_map|gtest_se2"
fi
