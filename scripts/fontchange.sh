#!/bin/bash

file='/home/dan/.config/alacritty/alacritty.yml'
fonts() {
    while IFS=$':' read a b c; do
        printf '%s\n' "${b# }"
    done < <(fc-list)
}
choice=$(fonts | sort -u | dmenu -i -l 15)

while read; do
    [[ "$REPLY" =~  [[:space:]]+family ]] && cf="${REPLY#????????????}" && break
done < "$file"

sed -i "s/$cf/$choice/g" "$file"
