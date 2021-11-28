#!/bin/sh
file='/home/dan/.config/alacritty/alacritty.yml'

choice=$(fc-list | cut -f2 -d: | sort -u | sed "s/^ *//" | dmenu -i -l 15)
[ -z "$choice" ] && { notify-send 'Nothing selected, exiting...' ; exit ;}

currentfont=$(sed -n '/family/ {p;q}' "$file")
currentfont=${currentfont#????????????}

sed -i "s/$currentfont/$choice/g" "$file"
