#!/bin/sh

if [ "$(command -v htop)" ]; then
    tp="htop"
else
    tp="top"
fi

ram=$(free -h | awk '/Mem/ {print $3}')
echo "🐏 "$ram""

case $BLOCK_BUTTON in
    1) "$TERMINAL" -e "$tp";;
    3) notify-send -t 8000 "$(ps axch -o cmd:10,%mem --sort=-%mem | sed 's/$/%/g' | head)" ;;
esac