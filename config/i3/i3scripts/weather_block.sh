#!/bin/sh

nws --statusbar

case $BLOCK_BUTTON in
  1) notify-send "$(nws)" ;;
  2) notify-send "$(nws --hourly)" ;;
  3) nws -r ;;
esac
