#!/bin/sh
#TODO
#fix vidurl
#test if you should use cut or grep first
#see if awk is useful in any of these


#search url of the site you are using
url="https://invidiou.site/search?q="

#get the string the user is searching for
search=$(echo "" | dmenu -i -fn "Liberation Mono-13" -nb "#282a36" -nf "#f8f8f2" -sb "#bd93f9" -p "Search: ")
[ -z "$search" ] && notify-send "Nothing selected... exiting" && exit 

#add search string to end of url
url="$url""$search"

#replace spaces with +'s
goodurl=$(echo "$url" | sed 's/ /+/g')
curl -s "$goodurl" > /tmp/utubegoodurl

#parse through html bs to get video titles
choice="$(cat /tmp/utubegoodurl | grep "/watch?v\=[a-zA-Z0-9]*" | cut -d'>' -f3 | sed '/^$/d' | dmenu -i -fn "Liberation Mono-13" -nb "#282a36" -nf "#f8f8f2" -sb "#bd93f9" -p "Pick vid" -l 20)"
[ -z "$choice" ] && notify-send "Nothing selected.. exiting" && exit

#parse through html bs to get video link
vidurl="https://invidiou.site""$(cat /tmp/utubegoodurl | grep -F "$choice" | grep -o '/watch?v\=[a-zA-Z0-9\-]*')"

echo "$vidurl" | xclip
mpv "$vidurl"

