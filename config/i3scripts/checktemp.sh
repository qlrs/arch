#!/bin/sh

temp=$(sensors | awk '/^Package id 0/ {print $4}')
echo "🌡️$temp"

case $BLOCK_BUTTON in
    1) notify-send -t 8000 "$(ps axch -o command:10,%cpu,pid --sort=-%cpu | head)" ;;
    3) notify-send -t 8000 "$(sensors | awk '/Core/ {print $1,$2,$3}')" ;;
esac
