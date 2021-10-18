#!/bin/sh
# Give file of names newline seperated

[ -z "$1" ] && { notify-send "No file given..." ; exit ;}

while read -r line; do
    title=$(echo "$line" | sed 's/^/thumbnail-/')
    # ffmpeg requires the -nostdin flag when used in loop
    ffmpeg -nostdin -i "$line" -vf scale=192:108 "$title"
done < "$1"
