#!/usr/bin/env bash

[ -z "$1" ] && { printf "No link given\n" ; exit 1 ;}

music=$HOME/music

songinfo() {
    read -p 'what would you like the artist directory to be called? ' -r artist
    [ -z "$artist" ] && { printf "Nothing entered\n" ; exit 2 ;}
    read -p 'what would you like the album directory to be called? ' -r album
    [ -z "$album" ] && { printf "Nothing entered\n" ; exit 2 ;}
}

songinfo

if [ -e "$music/$artist/$album" ]; then
    printf "That already exists\n"
    exit 3
else
    mkdir -p "$music/$artist/$album"
    yt-dlp -o "$music/$artist/$album/album.%(ext)s" --extract-audio --audio-format mp3 "$1"
    > "$music/$artist/$album/times"
fi
