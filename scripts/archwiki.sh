#!/bin/sh

[ ! -d "/usr/share/doc/arch-wiki" ] && notify-send "arch-wiki-docs package needed..." && exit 1

selection=$(find /usr/share/doc/arch-wiki/html/en -printf "%f\n" | dmenu -i -l 20)

[ -z "$selection" ] && notify-send "Nothing selected... exiting" && exit 1

firefox "/usr/share/doc/arch-wiki/html/en/$selection"
