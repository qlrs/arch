#!/bin/sh

chosenone=$(cut -d ';' -f1 ~/bin/emojilist | dmenu -i -l 30 | sed "s/ .*//")
[ -z "$chosenone" ] && exit
echo "$chosenone" | tr -d '\n' | xclip -selection "clipboard"
