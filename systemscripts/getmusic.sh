#!/bin/sh
#You need to specify downloadmusic in your youtube-dl config
#-o "$HOME"/downloadmusic/%(title)s.%(ext)s

musiclocation() {
    [ ! -d "$HOME"/downloadmusic ] && mkdir "$HOME"/downloadmusic
    cd "$HOME"/downloadmusic || exit
    mv * album
    mv album "$musicpath"
    cd "$musicpath" || exit
    touch times
}

echo "what would you like the artist directory to be called? "; read -r artistname
echo "what would you like the album directory to be called? "; read -r albumname
[ -z "$artistname" ] && notify-send "Nothing entered, exiting..." && exit
[ -z "$albumname" ] && notify-send "Nothing entered, exiting..." && exit
[ -z "$1" ] && notify-send "No link found, please enter a link" && exit

if { [ -e "$HOME"/music/"$artistname" ] && [ -e "$HOME"/music/"$artistname"/"$albumname" ]; }; then
    echo "That already exists"
elif { [ -e "$HOME"/music/"$artistname" ] && [ ! -e "$HOME"/music/"$artistname"/"$albumname" ]; }; then 
    mkdir -p "$HOME"/music/"$artistname"/"$albumname"
    cd "$HOME"/music/"$artistname"/"$albumname" || exit
    musicpath="$PWD"
    youtube-dl -f m4a "$1"
    musiclocation
else
    mkdir -p "$HOME"/music/"$artistname"/"$albumname"
    cd "$HOME"/music/"$artistname"/"$albumname" || exit
    musicpath=$PWD
    youtube-dl -f m4a "$1"
    musiclocation
fi
