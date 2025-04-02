#!/bin/sh

# song=$(mpc status | grep "%)" | awk '{ print $3 }' | awk -F/ '{ print $1 }' | awk -F: '{ print $1*60+$2 }')

song=$(mpc status | awk 'NR==1 {song=$0; next} {for(i=1;i<=NF;i++) {if ($i ~ /^[0-9]+:[0-9]+/) {print song " [" $i "]"; exit}}}')


printf "%s\n" "$song"

case "$BLOCK_BUTTON" in
    1) mpc toggle ;;
esac
