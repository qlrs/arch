#!/bin/sh
# Requires text file with names of pictures that you want, seperated by newlines
# Gives output that you can paste into your website html

# TODO
# replace wallpapers.html in place with sed

[ -z "$1" ] && notify-send "Please enter text file..." && exit

while read -r name; do
    thumbname="thumbnail-$name"
    html="<a href=pics/$name target_blank>\n\t<img src=pics/thumbs/$thumbname>\n\t</a>\n"
    printf '%s' "$html" >> /tmp/addtowallpapers.html
done < "$1"

forsed="$(cat /tmp/addtowallpapers.html)"
sed -i "/<\/p>/i $forsed" wallpapers.html
rm /tmp/addtowallpapers.html
