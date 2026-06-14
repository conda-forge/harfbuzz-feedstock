#!/bin/bash
set -ex

ninja -C builddir install -j ${CPU_COUNT}

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  # the required HarfBuzz-0.0.{gir,typelib} have already been created for
  # using build-native compilation in build.sh; move them manually
  mkdir -p $PREFIX/share/gir-1.0
  mkdir -p $PREFIX/lib/girepository-1.0
  cp $BUILD_PREFIX/share/gir-1.0/HarfBuzz-0.0.gir $PREFIX/share/gir-1.0/
  cp $BUILD_PREFIX/lib/girepository-1.0/HarfBuzz-0.0.typelib $PREFIX/lib/girepository-1.0/
fi

pushd $PREFIX
rm -rf share/gtk-doc
popd
