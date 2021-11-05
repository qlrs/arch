#!/bin/sh

#ps aux give it to dmenu, call this chosen
chosen="$(ps -axco pid,comm | dmenu -l 15 -p "What process to kill? " -i)"
[ -z "$chosen" ] && notify-send "Nothing selected... exiting" && exit

process=$(echo "$chosen" | awk '{print $1}')
kill "$process" && notify-send "$process... W A S T E D"
