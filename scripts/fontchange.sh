#!/bin/sh
#Location of file you wish to edit
file="/home/dan/.config/alacritty/alacritty.yml"


#Give dmenu list of fonts to choose from
choice=$(fc-list | cut -f2 -d: | sort -u | sed "s/^ *//" | dmenu -fn "Liberation Mono-13" -nb "#282a36" -nf "#f8f8f2" -sb "#bd93f9" -i -l 30)
[ -z "$choice" ] && notify-send "Nothing selected, exiting..." && exit


#Annoyingly extract the font name
currentfont=$(sed -n '/family/ {p;q}' "$file")
currentfont="${currentfont#????????????}"


#Replace old font with new
sed -i "s/$currentfont/$choice/g" "$file"
