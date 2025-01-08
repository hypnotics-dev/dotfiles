#!/usr/bin/env bash

set -e 

NVIM_GIT_PATH="$HOME/dev/git/neovim/"

cd "$NVIM_GIT_PATH"

echo "Updating nvim repo"

build () {
	echo "Building neovim with commit $(git log --oneline --shortstat | head -n1 | awk '{print $1}')"
	#echo "$(git log --oneline --shortstat | awk '{for (i=2;i<=NF;i++) print $i}')" # This seems to be broken
	sleep 1

	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}

nightly () {

	git switch master
	sudo make distclean
	git pull
	sleep 1
	git checkout nightly

	build

	git switch master
}

HEAD () {
	git switch master
	sudo make distclean
	git pull
	sleep 1

	build
}

if [ "$1" == ""  ]; then 
	echo "Building off of Nightly"
	nightly
else
	echo "Building off of HEAD"
	HEAD
fi

echo "Finished building NVIM"
