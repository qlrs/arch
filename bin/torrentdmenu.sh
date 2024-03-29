#!/bin/sh

#get the movie or w/e the user is searching for
query=$(echo "" | dmenu -fn "Liberation Mono-13" -nb "#000000" -nf "#ffffff" -sb "#0066ff" -i -p "Search torrent: ")
[ -z "$query" ] && notify-send "Nothing selected... exiting" && exit

searchurl="https://1337x.to/search/$query/1/"

curl -s "$searchurl" > /tmp/searchurl

#get seeds
grep "<td class=\"coll-2" /tmp/searchurl | sed 's/<[^>]*>//g' > /tmp/seeds
#get clean names
cat /tmp/searchurl | grep -o "/torrent/[0-9]\+/.*" | cut -d '/' -f4 > /tmp/names

#let user select list from clean names with seeders
chosen="$(paste /tmp/names /tmp/seeds -d ';' | dmenu -l 10 -fn "Liberation Mono-13" -nb "#000000" -nf "#ffffff" -sb "#0066ff" -i -p "Which one? ")"
[ -z "$chosen" ] && notify-send "Nothing selected... exiting" && exit

#extract name to use for searching for the actual torrent page
findingurl="$(echo "$chosen" | sed -e 's/ /\-/g' -e 's/(//g' -e 's/)//g' -e 's/\[//g' -e 's/\]//g' -e 's/\://g' | cut -d ';' -f1)"
echo "$findingurl"

#UNCOMMENT THIS IF NOT WORKING
#[ "$(echo "$findingurl" | grep "[0-9]$")" ] && findingurl=${findingurl%?}

pageurl="$(grep -o "torrent/[0-9]\+/$findingurl/" < /tmp/searchurl)"
curl -s "https://1337x.to/$pageurl" > /tmp/videourl

magnet="$(grep -o "magnet:?xt=urn:btih:[a-zA-Z0-9]*" < /tmp/videourl | sed -n '1p')"
setsid -f transmission-gtk "$magnet" && notify-send "Adding torrent" &
