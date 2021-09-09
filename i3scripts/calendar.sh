#!/bin/sh
#needs testing

case "$BLOCK_BUTTON" in 
    1) yad --calendar \
        --width=400 --height=400 \
	    --undecorated --fixed \
	    --close-on-unfocus --no-buttons \
	    --posx=1650 --posy=30 \
	    > /dev/null ;;
    3) "$TERMINAL" -e calcurse ;;
esac


echo "$(date +"%m-%d  %a  %I:%M") "
