#!/bin/sh
# Give url of picture or list with $url $name

[ -z "$1" ] && { notify-send 'Please enter a url or list' ; exit ;}

getone() {
    echo 'What do you want the file to be called? '; read -r name
    while true ; do
        if ! [ -e "/$HOME/stuff/walls/$name" ] ; then
            wget -q "$1" -O "/$HOME/stuff/walls/$name" 2> /dev/null
            echo "Downloaded $1 as $name"
            break
        else
            echo 'That file exists, please give another name ' ; read -r name
        fi
    done
}

getmultiple() {
    while read -r url name; do
        while true ; do
            if ! [ -e "/$HOME/stuff/walls/$name" ] ; then
                wget -q "$url" -O "/$HOME/stuff/walls/$name" 2> /dev/null
                break
            else
                echo "The file $name exists, please change the name."
                break
            fi
        done
    done < "$1"
}

if echo "$1" | grep -q "http"; then
    getone "$@"
else
    getmultiple "$@"
fi
