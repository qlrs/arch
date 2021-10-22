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
    2) mpc clear ;;
    3) mpc toggle ;;
    4) mpc next ;;
    5) mpc prev ;;
esac > /dev/null
