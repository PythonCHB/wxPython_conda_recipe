#!/bin/bash

## install wxPython from PyPI source or wheel

pkgname='wxPython'
pip_cmd='pip' #  $CONDA_PREFIX/bin/pip
pip_opts='-U' #  --force-reinstall --no-cache-dir'
osname=`uname -s`

## for Darwin, we can just do install on the fetched binary wheel,
if [[ "$osname" == Darwin ]] ; then
    $pip_cmd install $pip_opts $pkgname

elif [[ "$osname" == Linux ]] ; then

    ## for Linux, this fetched a source tarball that we now need to build.
    ##
    ## this follows build instructions using Fedora,
    ## which need the following packages installed:
    ##
    ## (sudo dnf/yum install)
    ##     dpkg  python-devel
    ##     webkitgtk webkitgtk-devel
    ##     freeglut freeglut-devel
    ##     libnotify libnotify-devel
    ##     libtiff libtiff-devel
    ##     libjpeg libjpeg-devel
    ##     SDL SDL-devel
    ##     gstreamer gstreamer-devel gstreamer-plugins-*

    $pip_cmd download $pkgname

    dirname=`ls | grep wxPython | sed 's/.tar.gz//g'`
    tar xvzf $dirname.tar.gz
    cd $dirname

    # custom complier flags and libs from gstreamer:
    export GST_LIBS=`pkg-config gstreamer-1.0 --libs`
    export GST_CFLAGS=`pkg-config gstreamer-1.0 --cflags`

    # we need to make the right sure libiconv is found for wxrc
    python build.py dox etg --nodoc sip
    python build.py build --extra_make='LIBS=-L$CONDA_PREFIX/lib -liconv'
    python build.py build_py
    python setup.py install

    # now copy the libwx* files from site-packages/wx to lib
    cp -pr $SP_DIR/wx/libwx* $CONDA_PREFIX/lib/.
fi
