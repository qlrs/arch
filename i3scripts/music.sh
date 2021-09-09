#!/bin/sh

song="$(mpc status | sed "/^volume:/d;s/\\&/&amp;/g;s/\\[paused\\].*/▶/g;/\\[playing\\].*/d" | paste -sd ' ')"

case $BLOCK_BUTTON in
    1) setsid -f $TERMINAL -e ncmpcpp;;
    2) mpc clear > /dev/null ;;
    3) mpc toggle > /dev/null ;;
    4) mpc next > /dev/null ;;
    5) mpc prev > /dev/null ;;
esac

