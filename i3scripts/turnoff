#!/bin/sh


case $BLOCK_BUTTON in
    1) 
        useranswer="$(zenity --entry --text="Type Y to shutdown")"
        case $useranswer in
            y|Y) poweroff;;
            *) notify-send "Have a nice day loser";;
        esac ;;
esac
