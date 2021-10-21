#!/bin/sh
### NEEDS A REWORK ###
# First argument is album file and second is time file formatted as
# 00:00:00 song name
# 00:03:00 song name_2

[ -z "$1" ] && echo "First argument is album, second is times" && exit
[ -z "$2" ] && echo "First argument is album, second is times" && exit

echo "What is the artist name? " ; read -r artistname
echo "What is the album name? " ; read -r albumname

[ -z "$artistname" ] && echo "Please enter an artist name" && exit
[ -z "$albumname" ] && echo "Pelase enter an album name" && exit

menu() {
    printf "\t1. opus\n"
    printf "\t2. mp3\n"
    read -r userext
}

while :; do
    menu
    echo "" 
    case "$userext" in
        1) userext=".opus" ; break ;;
        2) userext=".mp3" ; break ;;
        *) echo "Invalid Selection" ;;
    esac
    echo ""
done

echo""
echo""

counter=1
while read -r line; do
    end="$(echo "$line" | cut -d' ' -f1)"
    tracknum=$((counter - 1))

    [ -n "$start" ] &&
        echo "Working on $name" &&
        [ "$userext" = ".opus" ] && 
            ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" -to "$end" "$filename" 2> /dev/null && 
            printf "Artist=$artistname\nAlbum=$albumname\nTitle=$name\nTrack=$tracknum" | opustags -i -S "$filename"
        [ "$userext" = ".mp3" ] && 
            ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" -to "$end" "$filename" 2> /dev/null && 
            eyeD3 -Q --remove-all -a "$artistname" -A "$albumname" -t "$name" -n "$tracknum" "$filename"
        [ -z "$userext" ] && notify-send "Exiting..." && exit

                
    start="$end"
    echo 
    name=${line##?????????}
    fakefilename=$(echo "$name" | sed 's/\s/_/g')
    filename="$fakefilename""$userext"
    counter=$((counter + 1))


done < "$2"

tracknum=$((tracknum +1 ))
echo "Almost done... Working on $name"
[ "$userext" = ".opus" ] &&
    ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" "$filename" 2> /dev/null &&
    printf "Artist=$artistname\nAlbum=$albumname\nTitle=$name\nTrack=$tracknum" | opustags -i -S "$filename"
[ "$userext" = ".mp3" ] &&
    ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" "$filename" 2> /dev/null && 
    eyeD3 -Q --remove-all -a "$artistname" -A "$albumname" -t "$name" -n "$tracknum" "$filename"


rm "$1"
rm "$2"
