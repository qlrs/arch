#!/bin/sh
# Requires text file with names of pictures that you want, newline seperated
# Adds the necessary html to the wallpapers file and creates the thumbnails

[ -z "$1" ] && { echo "Requires a list of file names..." ; exit 1 ;}

while read -r name; do
    thumbname="thumbnail-${name}"
    html="<a href=pics/$name target_blank>\n\t<img src=pics/thumbs/$thumbname>\n\t</a>\n"
    printf '%s' "$html" >> /tmp/addtowallpapers.html

    # ffmpeg requires the -nostdin flag when used in loop
    ffmpeg -nostdin -i "$HOME/memes/website/pics/$name" -vf scale=192:108 "$HOME/memes/website/pics/thumbs/$thumbname"
done < "$1"

# vv???
forsed="$(cat /tmp/addtowallpapers.html)"
sed -i "/<\/p>/i $forsed" wallpapers.html
rm /tmp/addtowallpapers.html
