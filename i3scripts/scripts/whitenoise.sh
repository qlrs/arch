#!/bin/sh

case $BLOCK_BUTTON in
    1) mpv /home/dan/scripts/whitenoise.mp4 --no-video >/dev/null ;;
    3) pkill mpv ;;
esac
