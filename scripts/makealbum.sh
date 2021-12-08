#!/bin/sh
# First argument is album file and second is time file formatted as
# 00:00:00 song name
# 00:03:00 song name_2

{ [ -z "$1" ] || [ -z "$2" ] ;} && { echo 'First argument is album, second is times' ; exit ;}

echo "What is the artist name? " ; read -r artistname
echo "What is the album name? " ; read -r albumname

[ -z "$artistname" ] && echo "Please enter an artist name" && exit
[ -z "$albumname" ] && echo "Pelase enter an album name" && exit

menu() {
    printf '\t1. opus\n'
    printf '\t2. mp3\n'
    read -r userext
}

while :; do
    menu
    echo "" 
    case $userext in
        1) userext='.opus' ; break ;;
        2) userext='.mp3' ; break ;;
        *) echo 'Invalid Selection' ;;
    esac
done

counter=1
while read -r time song; do
    tracknum=$((counter - 1))
    [ -n "$start" ] &&
        echo "Working on $songname" &&
        if [ "$userext" = ".mp3" ]; then
            ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" -to "$time" "$filename" 2> /dev/null && 
            eyeD3 -Q --remove-all -a "$artistname" -A "$albumname" -t "$songname" -n "$tracknum" "$filename"
        else
            ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" -to "$time" "$filename" 2> /dev/null &&
            printf "Artist=$artistname\nAlbum=$albumname\nTitle=$songname\nTrack=$tracknum" | opustags -i -S "$filename"
        fi

    start=$time
    songname=$song
    filename=$(echo "$songname" | sed 's/\s/_/g' | tr '[:upper:]' '[:lower:]')$userext
    counter=$((counter + 1))

done < "$2"

tracknum=$((tracknum + 1 ))
echo "Almost done... Working on $songname"
    if [ "$userext" = ".mp3" ]; then
        ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" "$filename" 2> /dev/null && 
        eyeD3 -Q --remove-all -a "$artistname" -A "$albumname" -t "$songname" -n "$tracknum" "$filename"
    else
        ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" "$filename" 2> /dev/null &&
        printf "Artist=$artistname\nAlbum=$albumname\nTitle=$songname\nTrack=$tracknum" | opustags -i -S "$filename"
    fi

rm "$1"
rm "$2"
