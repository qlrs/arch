#!/bin/sh


file="/home/dan/.Xdefaults"


choice="$(fc-list | cut -f2 -d: | sort -u | sed "s/^ *//" | dmenu -fn "Liberation Mono-13" -nb "#282a36" -nf "#f8f8f2" -sb "#bd93f9" -i -l 30)"
[ -z "$choice" ] && notify-send "Nothing selected, exiting..." && exit


currentfont="$(cat ~/.Xdefaults | sed -n '/xft/ {p;q}')"
currentfont="${currentfont#????????????????}"
currentfont="${currentfont%??????????????????????}"


sed -i "s/$currentfont/$choice/g" "$file"
xrdb ~/.Xdefaults
