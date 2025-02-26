#!/usr/bin/env bash

ERROR_FILE_SWWW="/var/log/swww_switcher"

# Error loging and printing
eprint() {
    >&2 echo $@;
    echo "$(date +"%Y-%m-%d@%T") => $@" >> $ERROR_FILE
}

set_random() {
    # $1 is the path to look for img
    # $2? is the symlink to the file to exclude from the search ?(readlink -f)?
    # $3? is the symlink to the file to exclude from the search ?(readlink -f)?
    ERR_BAD_FILE=1

    if [ -z ${1+x} ]; then
        eprint "PATH for img is not set"
        exit ERR_BAD_FILE
    fi

    # Array with the imgs
    local -a imgs
    imgs=($(ls $1))

    local ex
    local -a tmp
    if [ -z ${2+x} ]; then
        # excludes file from search
        tmp=()
        # Get the absolute name of the origin of the symlink
        echo "READLINK 3"
        ex="$(readlink -f $2)"
        for i in "${imgs[@]}";do
            if [[ "$i" != "$ex" ]];then
                tmp+=("$i")
            fi
        done
        imgs=tmp
    fi
    if [ -z ${3+x} ]; then
        tmp=()
        ex="$(readlink -f $3)"
        echo "READLINK 3"
        for i in "${imgs[@]}";do
            if [[ "$i" != "$ex" ]];then
                tmp+=("$i")
            fi
        done
        imgs=tmp
    fi

    local d1
    local d2

    # d1 = "${imgs[$((RANDOM % ${#imgs[@]}))]}"
    # d2 = "${imgs[$((RANDOM % ${#imgs[@]}))]}"
    # while [[ "$d1" == "$d2" ]]; do
    #     d1 = "${imgs[$((RANDOM % ${#imgs[@]}))]}"
    #     d2 = "${imgs[$((RANDOM % ${#imgs[@]}))]}"
    # done
    # TODO make this script work with N screens instead of just the 2
    # Do while ????!?!?!?!?!?
    while 
        d1="${imgs[$((RANDOM % ${#imgs[@]}))]}"
        d2="${imgs[$((RANDOM % ${#imgs[@]}))]}"
        [[ "$d1" == "$d2" ]] 
    do true; done

    # Seting the desktops
    swww img -o DP-3 "$1/$d1"
    swww img -o HDMI-A-1 "$1/$d2"
}
