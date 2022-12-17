#!/bin/sh

c="$(cat /sys/class/power_supply/BAT1/capacity)"
s="$(cat /sys/class/power_supply/BAT1/status)"

# [ "$c" -lt 21 ] && echo "⚠️🔋 ${s%??????}- $c%" || echo "🔋 ${s%??????}- $c%"
# [ "$c" -lt 21 ] && 

if [ "$c" -lt 21 ]; then
    echo "⚠️🔋 ${s%??????}- $c%"
    notify-send "⚠️ Battery $c% ⚠️"
else
    echo "🔋 ${s%??????}- $c%"
fi

