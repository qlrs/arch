#!/bin/sh
# Give file of names newline seperated

[ -z "$1" ] && { echo 'No file given' ; exit 1 ;}

while read -r name; do
    thumbname="thumbnail-$name"
    # ffmpeg requires the -nostdin flag when used in loop
    ffmpeg -nostdin -i "$name" -vf scale=192:108 "$thumbname"
done < "$1"
