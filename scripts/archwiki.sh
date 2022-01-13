#!/bin/bash
[ ! -d "/usr/share/doc/arch-wiki" ] && { notify-send "arch-wiki-docs package needed..." ; exit 1 ;}

var=''
for i in /usr/share/doc/arch-wiki/html/en/*; do
    var+="${i##*/}"$'\n'
done

selection=$(printf "%s\n" "$var" | dmenu -i -l 20)

[ -z "$selection" ] && { notify-send "Nothing selected" ; exit 2 ;}

"$BROWSER" "/usr/share/doc/arch-wiki/html/en/$selection" 2> /dev/null
