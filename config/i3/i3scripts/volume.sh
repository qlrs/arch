#!/bin/sh

case $BLOCK_BUTTON in
    1) pamixer -tt;; # Mutes
    2) pamixer --set-volume 100 ;;
    3) $TERMINAL -e pulsemixer ;;
    4) pamixer --allow-boost -i 5 ; notify-send 'volume increased' ;; # Scroll up/down for increase/decrease
    5) pamixer --allow-boost -d 5 ; notify-send 'volume decreased' ;;
esac

currentvolume=$(pamixer --get-volume)

if "$(pamixer --get-mute)" > /dev/null; then
    icon=🔇
else
    icon=🔊
fi

echo "$icon $currentvolume"
