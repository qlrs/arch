#!/bin/sh

case $BLOCK_BUTTON in
    1) $TERMINAL -e pulsemixer ;;
    2) pamixer --set-volume 100 ;;
    3) pamixer -t ;; #mutes
    4) pamixer --allow-boost -i 5 ; notify-send "volume increased" ;; #scroll up/down for increase/decrease
    5) pamixer --allow-boost -d 5 ; notify-send "volume decreased" ;;
esac


currentvolume=$(pamixer --get-volume)

if [ "$(pamixer --get-mute)" = true ]; then
    icon="🔇"
else
    icon="🔊"
fi

echo "$icon $currentvolume"
