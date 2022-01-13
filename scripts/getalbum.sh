#!/bin/sh
[ -z "$1" ] && { echo 'No link given' ; exit 1 ;}

music=$HOME/music

songinfo() {
    echo "what would you like the artist directory to be called? "; read -r artist
    [ -z "$artist" ] && { echo 'Nothing entered' ; exit 2 ;}
    echo "what would you like the album directory to be called? "; read -r album
    [ -z "$album" ] && { echo 'Nothing entered' ; exit 2 ;}
}

songinfo

if [ -e "$music/$artist/$album" ]; then
    echo 'That already exists'
    exit 3
else
    mkdir -p "$music/$artist/$album"
    yt-dlp -o "$music/$artist/$album/album.%(ext)s" --extract-audio --audio-format mp3 "$1"
    touch "$music/$artist/$album/times"
fi
