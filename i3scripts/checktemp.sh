#!/bin/sh

temp=$(sensors | awk '/^Package id 0/ {print $4}')
echo "🌡️ $temp"

case $BLOCK_BUTTON in
    3) notify-send -t 8000 "$(sensors | sed -n '5,18p' | sed 's/([^)]*)//g')"
esac

