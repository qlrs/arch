#!/bin/sh

pkill -RTMIN+13 i3blocks && notify-send "Volume 🔊 $(pamixer --get-volume)"
