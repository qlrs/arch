#!/bin/sh

if "$(pamixer --get-mute)" > /dev/null; then
    icon=🔇
else
    icon=🔊
fi

notify-send "$icon"
