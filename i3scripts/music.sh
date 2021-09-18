#!/bin/sh

case $BLOCK_BUTTON in
    1) setsid -f "$TERMINAL" -e ncmpcpp;;
    2) mpc clear > /dev/null ;;
    3) mpc toggle > /dev/null ;;
    4) mpc next > /dev/null ;;
    5) mpc prev > /dev/null ;;
esac
