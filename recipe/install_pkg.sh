#!/bin/bash
set -ex

ninja -C builddir install -j ${CPU_COUNT}

pushd $PREFIX
rm -rf share/gtk-doc
popd
