#!/bin/sh

case $BLOCK_BUTTON in
    1) mpc clear > /dev/null ; mpc add shit/whitenoise.mp4 ; mpc toggle > /dev/null ;;
esac
