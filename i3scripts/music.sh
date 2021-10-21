#!/bin/sh

if mpc | grep -q "playing"; then
    echo "⏸️ 🎶"
elif
    mpc | grep -q "paused"; then
    echo "▶️ 🎶"
else
    echo "🎶"
fi

case $BLOCK_BUTTON in
    1) setsid -f "$TERMINAL" -e ncmpcpp;;
    2) mpc clear > /dev/null ;;
    3) mpc toggle > /dev/null ;;
    4) mpc next > /dev/null ;;
    5) mpc prev > /dev/null ;;
esac
