#!/bin/sh
# Might need to switch to youtube-dlp

[ -z "$1" ] && notify-send "No link given... Exiting" && exit

songinfo() {
    echo "what would you like the artist directory to be called? "; read -r artistname
    echo "what would you like the album directory to be called? "; read -r albumname
    [ -z "$artistname" ] && notify-send "Nothing entered, exiting..." && exit
    [ -z "$albumname" ] && notify-send "Nothing entered, exiting..." && exit
}

songinfo

if { [ -e "$HOME/music/$artistname" ] && [ -e "$HOME/music/$artistname/$albumname" ]; }; then
    echo "That already exists"
else
    mkdir -p "$HOME/music/$artistname/$albumname"
    youtube-dl -o "$HOME/music/$artistname/$albumname/album.%(ext)s" --extract-audio --audio-format mp3 "$1"
    touch "$HOME/music/$artistname/$albumname/times"
fi
