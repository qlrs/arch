#!/bin/sh

[ -z "$1" ] && { echo 'No link given... Exiting' ; exit 1 ;}

music="$HOME/music"

songinfo() {
    echo "what would you like the artist directory to be called? "; read -r artistname
    echo "what would you like the album directory to be called? "; read -r albumname
    [ -z "$artistname" ] && { echo 'Nothing entered, exiting...' ; exit 1 ;}
    [ -z "$albumname" ] && { echo 'Nothing entered, exiting...' ; exit 1 ;}
}

songinfo

if { [ -e "$music/$artistname" ] && [ -e "$music/$artistname/$albumname" ]; }; then
    echo 'That already exists'
else
    mkdir -p "$music/$artistname/$albumname"
    yt-dlp -o "$music/$artistname/$albumname/album.%(ext)s" --extract-audio --audio-format mp3 "$1"
    touch "$music/$artistname/$albumname/times"
fi
