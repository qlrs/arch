#!/bin/bash
[ -z "$1" ] && { printf "No link given\n" ; exit 1 ;}

songinfo() {
    read -p 'Artist name: ' -r artistname
    dirartistname=${artistname,,}
    dirartistname=${dirartistname// /_}

    read -p 'Song name: ' -r songname
    filename=${songname,,}
    filename=${filename// /_}

    musicpath=$HOME/music/$dirartistname
}

processsong() {
    yt-dlp -o "$musicpath/$filename.%(ext)s" \
        --extract-audio --audio-format mp3 "$@"
    eyeD3 -Q --remove-all -a "$artistname" -t "$songname" \
        "$musicpath/$filename.mp3"
}

songinfo

mkdir -p "$musicpath" && processsong "$1"
