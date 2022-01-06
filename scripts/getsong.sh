#!/bin/sh
# Might need to switch to youtube-dlp to uncap download limit

[ -z "$1" ] && { echo 'No link given... exiting.' ; exit 1 ;}

songinfo() {
    echo 'Artist directory name? '; read -r dirartistname
    echo 'Song file name? '; read -r filename
    echo 'Artist name? ' ; read -r artistname
    echo 'Song name?' ; read -r songname
}

processsong() {
    musicpath="$HOME"/music/"$dirartistname"
    yt-dlp -o "$musicpath/$filename.%(ext)s" \
        --extract-audio --audio-format mp3 "$@"
    #cd "$musicpath" || exit
    eyeD3 -Q --remove-all -a "$artistname" -t "$songname" \
        "$musicpath"/"$filename.mp3"
}

songinfo

mkdir -p "$HOME"/music/"$dirartistname" ; processsong "$1"
