#!/usr/bin/env bash

MAIN="$HOME/stuff/images/wallpaper/main"
ALT="$HOME/stuff/images/wallpaper/alt"

if pgrep -x swww-daemon > /dev/null;then 
    echo ''
else 
    swww-daemon&
fi

LastMain="$( swww query | grep DP-3 | awk -F '/' '{print $8}')"
if [[ $LastMain = "" ]];then LastMain="$(ls $MAIN/ | sort -R | head -n 1)";fi

LastAlt="$( swww query | grep HDMI-A-1 | awk -F '/' '{print $8}')"
if [[ $LastAlt = "" ]];then LastAlt="$(ls $ALT/ | sort -R | head -n 1)";fi

rand-t () {
    t=("fade" "wipe" "wave" "grow" "center" "any")
    echo ${t[ $RANDOM % ${#t[@]} ]}
}

rand-main () {
    local wall=$(ls $MAIN | grep -v $LastMain | sort -R | head -n1 )
    swww img -o 'DP-3' --resize 'fit' -t $(rand-t) $MAIN/$wall 
}

rand-alt () {
    local wall=$(ls $ALT | grep -v $LastAlt | sort -R | head -n1)
    swww img -o 'HDMI-A-1' --resize 'fit' -t $(rand-t) $ALT/$wall 
}


if [[ $1 = 'alt' ]];then 
    rand-alt
elif [[ $1 = 'main' ]];then
    rand-main
else 
    rand-main
    rand-alt
fi


