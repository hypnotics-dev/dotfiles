#!/usr/bin/env bash

set -e 

NVIM_GIT_PATH="$HOME/dev/git/neovim/"

cd "$NVIM_GIT_PATH"

echo "Updating nvim repo"

git switch master
sudo make distclean
git pull
sleep 1
git checkout nightly


echo "Building neovim with commit $(git log --oneline --shortstat | head -n1 | awk '{print $1}')"
#echo "$(git log --oneline --shortstat | awk '{for (i=2;i<=NF;i++) print $i}')" # This seems to be broken
sleep 1

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
git switch master

echo "Finished building NVIM"
