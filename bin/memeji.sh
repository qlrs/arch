#!/bin/sh

chosenone=$(cut -d ';' -f1 ~/scripts/emojilist | dmenu -i -l 30 | sed "s/ .*//")
[ -z "$chosenone" ] && { notify-send "Nothing selected... exiting" ; exit ;}
echo "$chosenone" | tr -d '\n' | xclip &