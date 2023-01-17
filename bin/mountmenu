#!/usr/bin/env bash

show_drives()
{
while read -r a b c d e f; do
    if [[ $f =~ part$ ]]; then
        printf '%s %-15s (%s)\n' "$a" "$f" "$d"
    fi
done < <(lsblk -lp)
}

mount_drive()
{
    location=$(printf "$HOME/storagedrive\n$HOME/usbstick" | dmenu -i -l 5 -p 'Choose mount point or type one')
    [ -z "$location" ] && exit 2
    [ ! -d "$location" ] && mkdir -p "$location"
    sudo mount "$selection" "$location"
    notify-send "Mounting $selection to $location"
}

selection=$(show_drives | dmenu -i -l 5 -p 'Enter drive to mount')
[ -z "$selection" ] && exit 1
selection=${selection%% *}

mount_drive
