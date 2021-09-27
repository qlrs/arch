#!/bin/sh

[ -z "$1" ] && notify-send "No link" && exit

songinfo() {
    echo "What would you like the artist directory to be called? "; read -r dirartistname
    echo "What would you like the song file to be called? "; read -r filename

    echo "What is the artist name? " ; read -r artistname
    echo "What is the song name? " ; read -r songname
}

processsong() {
    musicpath="$HOME"/music/"$dirartistname"
    youtube-dl -o "$musicpath"/"$filename.%(ext)s" --extract-audio --audio-format mp3 "$@"
    cd "$musicpath" || exit
    eyeD3 -Q --remove-all -a "$artistname" -t "$songname" "$filename.mp3"
}

songinfo

if [ -e "$HOME"/music/"$dirartistname" ]; then
    processsong "$1"
else
    mkdir -p "$HOME"/music/"$dirartistname" ; processsong "$1"
fi
