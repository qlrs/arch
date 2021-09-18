#!/bin/sh

command -v htop > /dev/null && tp="htop" || tp="top"

ram=$(free -h | awk '/Mem/ {print $3}')
echo "🐏 $ram"

case $BLOCK_BUTTON in
    1) "$TERMINAL" -e "$tp";;
    3) notify-send -t 8000 "$(ps axch -o cmd:10,%mem --sort=-%mem | sed 's/$/%/g' | head)" ;;
esac
