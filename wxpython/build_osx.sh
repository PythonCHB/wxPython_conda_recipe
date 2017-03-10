#!/bin/bash

## build script tested on OS-X

#PYTHON=python2.7

cd wxPython
$PYTHON build-wxpython.py --prefix=$PREFIX --build_dir=../bld --osx_cocoa --install

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
