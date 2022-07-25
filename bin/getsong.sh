#!/bin/sh
[ -z "$1" ] && { echo 'No link given... exiting.' ; exit 1 ;}

songinfo() {
    echo 'Artist directory name? '; read -r dirartistname
    echo 'Song file name? '; read -r filename
    echo 'Artist name? ' ; read -r artistname
    echo 'Song name? ' ; read -r songname
    musicpath=$HOME/music/$dirartistname
}

processsong() {
    yt-dlp -o "$musicpath/$filename.%(ext)s" \
        --extract-audio --audio-format mp3 "$@"
    #cd "$musicpath" || exit
    eyeD3 -Q --remove-all -a "$artistname" -t "$songname" \
        "$musicpath/$filename.mp3"
}

songinfo

mkdir -p "$musicpath" && processsong "$1"
