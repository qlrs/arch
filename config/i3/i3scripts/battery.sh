#!/bin/sh

c="$(cat /sys/class/power_supply/BAT1/capacity)"
s="$(cat /sys/class/power_supply/BAT1/status)"

if [ "$c" -lt 21 ]; then
    echo "⚠️🔋 ${s%??????}- $c%"
    notify-send "⚠️ Battery $c% ⚠️"
else
    echo "🔋 ${s%??????}- $c%"
fi

time_left=$(acpi | tail -n1 | cut -d ',' -f3)

case "$BLOCK_BUTTON" in
    1) notify-send "${time_left#?}"
esac
