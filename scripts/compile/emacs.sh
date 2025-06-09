#!/usr/bin/env bash

set -e

flags=(
    "--with-x-toolkit=no"
    "--with-native-compilation=aot"
    "--sysconfdir=/etc"
    "--prefix=/usr"
    "--with-sound=no"
    "--with-pgtk"
    "--without-gsettings"
    "--without-selinux"
    # "--with-xwidgets"
    "--enable-link-time-optimization"
    "--libexecdir=/usr/lib"
    "--with-imagemagick"
    "--with-tree-sitter"
    "--localstatedir=/var"
    "--with-cairo"
    "--disable-build-details"
    "--with-harfbuzz"
    "--with-libsystemd"
    "--with-modules" 
)

EMACS_DIR="/home/hypnotics/dev/git/emacs/"
# echo ${flags[@]}
cd $EMACS_DIR
sudo git clean -fdx
git pull
sleep 5
./autogen.sh
mkdir build
cd build

CFLAGS='-march=x86-64 -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3 -Wformat \
-Werror=format-security -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer \
-mno-omit-leaf-frame-pointer -g -ffile-prefix-map=/build/emacs/src=/usr/src/debug/emacs \
-flto=auto' \
# LDFLAGS='-Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now  \
# -Wl,-z,pack-relative-relocs -flto=auto' \
# CXXFLAGS='-march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3 \
# -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection \
# -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer \
# -Wp,-D_GLIBCXX_ASSERTIONS -g -ffile-prefix-map=/build/emacs/src=/usr/src/debug/emacs -flto=auto' \
../configure "${flags[@]}"

make -j 12
sudo make -j 12 install 


