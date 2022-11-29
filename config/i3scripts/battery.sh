#!/bin/sh

c="$(cat /sys/class/power_supply/BAT0/capacity)"
s="$(cat /sys/class/power_supply/BAT0/status)"

[ $c -lt 21 ] && echo "⚠️🔋 ${s%??????}- $c%" || echo "🔋 ${s%??????}- $c%"
