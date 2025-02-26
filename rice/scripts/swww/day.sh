#!/usr/bin/env bash
source ./base.sh

IMG_SOURCE_SWWW_EV="$HOME/stuff/images/wallpaper/active/day/"
IMG_PREV_SWWW_EV1="$HOME/stuff/images/wallpaper/active/prev/day1"
IMG_PREV_SWWW_EV2="$HOME/stuff/images/wallpaper/active/prev/day2"


# There is no history to exlude
if [ -f $IMG_PREV_SWWW_EV1 ];then
    rm $IMG_PREV_SWWW_EV1
fi
if [ -f $IMG_PREV_SWWW_EV2 ];then
    rm $IMG_PREV_SWWW_EV2
fi

prev1=$(swww query | awk -F ":" '{print $5}' | head -n1)
prev2=$(swww query | awk -F ":" '{print $5}' | tail -n1)

ln -s $prev1 $IMG_PREV_SWWW_EV1
ln -s $prev2 $IMG_PREV_SWWW_EV2

notify-send -app-name=Wallpaper "Switching to DAY theme" --icon="/home/hypnotics/.local/share/icons/customs/day.png"
set_random $IMG_SOURCE_SWWW_EV $IMG_PREV_SWWW_EV1 $IMG_PREV_SWWW_EV2
