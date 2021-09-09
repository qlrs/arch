#!/bin/sh
#Give url of picture or a spaced list such as
#url name


[ -z "$1" ] && notify-send "Please enter a url or list" && exit


if echo "$1" | grep -q "http"; then
    echo "What do you want the file to be called? "; read -r name
    wget "$1" -O "$name"
    mv "$name" "$HOME"/walls
else
    while read -r url name; do
        wget "$url" -O "$name"
        mv "$name" "$HOME"/walls
    done < "$1"
fi
