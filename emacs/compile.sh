#!/usr/bin/env bash

flags=(
    "--enable-gcc-warnings=no"
    "--enable-link-time-optimization"
    "--with-mailutils"
    "--with-sound=no"
    "--with-x-toolkit=no"
    "--with-imagemagick"
    "--with-pgtk"
    "--without-gsettings"
    "--without-selinux"
    "--with-xwidgets"
    "--with-native-compilation=aot"
    "--program-suffix=30"
)

./autogen.sh
mkdir build
cd build
../configure ${flags[@]}
make -j 12
sudo make -j 12 install 

