#!/bin/bash
file=$HOME/.xprofile

while read -r; do
    if [[ $REPLY =~ walls ]]; then
        current=${REPLY##*/}
    fi
done < "$file"

sed -i "s,$current,/home/stuff/walls/$1,g" "$file"
xwallpaper --stretch "$1" &> /dev/null
