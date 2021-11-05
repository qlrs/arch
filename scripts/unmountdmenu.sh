#!/bin/sh

getchoice="$(lsblk -lpo +HOTPLUG | grep '1$' | awk '/part[[:space:]]/ {print $1,$7}' | dmenu -fn -i -l 10 -p "Choose drive to unmount: ")"
[ -z "$getchoice" ] && notify-send "Nothing selected... exiting" && exit

locationtounmount="$(echo "$getchoice" | cut -d ' ' -f2)"
echo "$locationtounmount"
sudo umount "$locationtounmount" || { notify-send "Error... exiting" ; exit 1 ;}
