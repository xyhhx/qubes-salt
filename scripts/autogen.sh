#!/bin/bash --
set -xeuo pipefail

autoreconf -imWall || (

  test -d .m4 || mkdir .m4
  test -f aclocal.m4 || aclocal -I .m4
  test -f configure || autoconf -DVERSION="$VERSION" -DPACKAGE_URL="$PACKAGE_URL" -DRELEASE="$RELEASE"
  test -f Makefile || automake --add-missing --copy

)

./configure

exit 0
