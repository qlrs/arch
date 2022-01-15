#!/bin/sh
#needs testing

case $BLOCK_BUTTON in 
    1) yad --calendar \
        --width=300 --height=300 \
	    --undecorated \
	    --close-on-unfocus --no-buttons \
	    --posx=1500 --posy=30 \
	    > /dev/null ;;
    3) "$TERMINAL" -e calcurse ;;
esac


echo "$(date +"%m-%d  %a  %I:%M") "
