#!/bin/sh

streamerfunc() {
    streamer=$(printf "xQcOW\nTrihex\nDestiny\nElajjaz\nLilyPichu\nWillNeff" | dmenu -i -l 10)
    [ -z "$streamer" ] && notify-send "Nothing selected, exiting..." && exit 1
    notify-send "Opening $streamer's Stream..."
    mpv "https://www.twitch.tv/$streamer"
    [ "$?" -eq 2 ] && notify-send "$streamer is offline ☹️" && exit 1
}

streamerfunc
