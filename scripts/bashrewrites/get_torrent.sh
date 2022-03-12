#!/usr/bin/env bash
# TODO
# Save torrent.txt in /tmp or something
# check grep calls to see if i can use pure bash

set -euo pipefail

get_seeds()
{
    counter=0
    while read -r; do
        if [[ $REPLY == *coll-2* ]]; then
            if [[ $counter -eq 0 ]]; then # Skip first line
                counter=$((counter + 1))
                continue
            else
                holder=${REPLY: 25}
                printf "%s\n" "${holder%<*}"
                counter=$((counter + 1))
            fi
        fi
    done < "$1"
}

get_names()
{
output=$(grep -oE 'torrent/[0-9]+/[^"]*' "$1")
while IFS=/ read -r line1 line2 line3; do
    line3=${line3//-/ }
    printf "%s\n" "$line3"
done <<< "$output"
}

show_movies()
{
    while read -r line1 && read -r line2 <&3; do
        printf "%5s %s\n" "$line1" "$line2"
    done < "$1" 3< "$2"
}

get_movie_page()
{
    tmp=$(printf "%s" "${choice// /-}" | grep -o '[a-zA-Z].*')
    page=$(grep -oE "torrent/[0-9]+/$tmp" 'torrent.txt')
    curl -s "$pageurl$page/" > 'movie_page.txt'
}

download_movie()
{
    magnet=$(grep -om 1 'magnet:?xt=urn:btih:[a-zA-Z0-9]*' movie_page.txt)
    setsid -f transmission-gtk "$magnet" &
    notify-send 'Adding torrent'
}
    
search=$(printf "" | dmenu -p 'What do you want to search for? ')
searchurl="https://1337x.to/search/${search// /_}/1/"
pageurl="https://1337x.to/"

curl -s "$searchurl" > "$HOME"/linuxbook/bashstuff/torrent.txt

get_seeds 'torrent.txt' > seeds.txt

get_names 'torrent.txt' > names.txt

choice=$(show_movies 'seeds.txt' 'names.txt' | dmenu -l 20)

get_movie_page

download_movie
