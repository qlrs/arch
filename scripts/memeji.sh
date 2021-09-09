#!/bin/sh

chosenone=$(cut -d ';' -f1 ~/scripts/emojilist | dmenu -fn "Liberation Mono-13" -nb "#000000" -nf "#ffffff" -sb "#0066ff" -i -l 30 | sed "s/ .*//")
[ -z "$chosenone" ] && { notify-send "Nothing selected... exiting" ; exit ;}
echo "$chosenone" | tr -d '\n' | xclip &
