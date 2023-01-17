#!/usr/bin/env bash

chosen=$(ps -axco pid,comm | dmenu -l 15 -p 'What process to kill? ' -i)
[ -z "$chosen" ] && { notify-send 'Nothing selected' ; exit 1 ;}

process=${chosen% *}
process=${process// /}
kill "$process" && notify-send "$process... W A S T E D"
