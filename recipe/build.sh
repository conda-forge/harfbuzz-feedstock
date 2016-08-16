#!/bin/bash

# Get rid of bad `defaults` .la files.
rm -rf $PREFIX/lib/*.la

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

make -j${CPU_COUNT}
make check
make install
