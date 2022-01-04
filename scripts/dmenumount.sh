#!/bin/sh

drives=$(lsblk -lp | awk '/part[[:blank:]]$/ {print $1, "("$4")"}')
[ -z "$drives" ] && exit 1

selec=$(echo "$drives" | dmenu -i -l 5 -p "Enter drive to mount: " | awk '{print $1}')
[ -z "$selec" ] && { notify-send "Nothing selected, exiting..." ; exit 1 ;}

ml=$(printf "/home/dan/storagedrive\n/mnt/usbstick\n/media" | dmenu -i -l 5 -p "Choose where to mount the drive: ")
if [ ! -d "$ml" ]; then
    newdir=$(printf "Yes\nNo" | dmenu -i -p "Mount point does not exist, create it?")
    if [ "$newdir" = "Yes" ];then
        sudo -A mkdir -p "$ml"
    else
        notify-send "Nothing selected, exiting... " ; exit 1
    fi
fi

sudo mount "$selec" "$ml" && notify-send "Mounting..."
