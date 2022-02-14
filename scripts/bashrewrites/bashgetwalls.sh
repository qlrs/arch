#!/usr/bing/env bash
# Give url of picture or list with $url $name
[ -z "$1" ] && { printf "Please enter a url or list\n" ; exit 1 ;}

getone() {
    read -p 'What do you want the file to be called? ' -r name
    while true ; do
    if [ -e "$HOME/stuff/walls/$name" ]; then
        read -p 'That file exists, please give another name ' -r name
    else
        wget -q "$1" -O "/$HOME/stuff/walls/$name" 2> /dev/null
        printf "Downloaded %s as %s\n" "$1" "$name"
        break
    fi
    done
}

getmultiple() {
    while read -r url name; do
        while true ; do
            if [ -e "/$HOME/stuff/walls/$name" ] ; then
                printf "The file %s exists, please change the name.\n" "$name"
                break
            else
                wget -q "$url" -O "/$HOME/stuff/walls/$name" 2> /dev/null
                break
            fi
        done
    done < "$1"
}

if [[ $1 = http* ]]; then
    getone "$@"
else
    getmultiple "$@"
    rm "$1"
fi
