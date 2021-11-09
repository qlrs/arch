#!/bin/sh

# Gives number of packages that need to be updated
echo "⬆️ $(sudo pacman -Qqu | wc -l)"

case $BLOCK_BUTTON in
    1) notify-send -t 6000 "$(pacman -Qu)" ;;
esac
