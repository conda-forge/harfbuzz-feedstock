#!/bin/bash

# Get rid of bad `defaults` .la files.
rm -rf $PREFIX/lib/*.la

# Set in conda_forge_build_setup to `${MAKEFLAGS}` and that breaks the build here.
export MAKEFLAGS=""

if [ $(uname) == Darwin ]; then
  export CC=clang
  export CXX=clang++
  export MACOSX_DEPLOYMENT_TARGET="10.9"
  export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
  export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
  export OPTS=""
elif [[ $(uname) == Linux ]]; then
  export OPTS="--with-gobject"
fi

autoreconf --force --install

bash configure --prefix=$PREFIX \
               --disable-gtk-doc \
               --enable-static \
               $OPTS

make
make check
make install
