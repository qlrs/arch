#!/bin/sh
#give text document of file names, newline seperated


[ -z "$1" ] && notify-send "No file given..." && exit


while IFS= read -r line; do
    title=$(echo "$line" | sed 's/^/thumbnail-/')
    ffmpeg -nostdin -i "$line" -vf scale=192:108 "$title" #ffmpeg requires the -nostdin flag when used in loop
done < "$1"
