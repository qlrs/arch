#!/bin/sh

nws --statusbar

case $BLOCK_BUTTON in
  1) nws --r;;
  3) notify-send -t 8000 "$(nws --hourly)";;
esac
