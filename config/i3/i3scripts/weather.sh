#!/bin/sh

nws daily | awk '/Temperature/ { print $2 }'

case $BLOCK_BUTTON in
  1) notify-send "$(nws)" ;;
  2) notify-send "$(nws hourly)" ;;
  3) nws radar ;;
esac
