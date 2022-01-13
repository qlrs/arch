#!/bin/bash
# First argument is album file and second is time file formatted as
# 00:00:00 song name
# 00:03:00 song name_2

{ [ -z "$1" ] || [ -z "$2" ] ;} && { echo 'First argument is album, second is times' ; exit 1 ;}

read -p 'What is the artist name? ' -r artistname
[ -z "$artistname" ] && echo 'Please enter an artist name' && exit 2
read -p 'What is the album name? ' -r albumname
[ -z "$albumname" ] && echo 'Please enter an album name' && exit 2

menu() {
    printf '\t1. mp3\n\t2. opus\n\tOr type q to quit\n'
    read -r answer
}

while : ;do
    menu
    case $answer in 
        1) userext='.mp3'; break ;;
        2) userext='.opus' ; break ;;
        q) echo 'Exiting' ; break ;;
        *) echo 'Invalid selection' ;;
    esac
done

counter=1
while read -r time song; do
    tracknum=$((counter - 1))
    [ "$start" ] &&
        echo "Working on $songname" &&
        if [ "$userext" = '.mp3' ]; then
            ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" -to "$time" "$filename" 2> /dev/null && 
            eyeD3 -Q --remove-all -a "$artistname" -A "$albumname" -t "$songname" -n "$tracknum" "$filename"
        else
            ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" -to "$time" "$filename" 2> /dev/null &&
            printf "Artist=%s\nAlbum=%s\nTitle=%s\nTrack=%s" "$artistname" "$albumname" "$songname" "$tracknum" | opustags -i -S "$filename"
        fi

    start=$time
    songname=$song # Needed for the last song outside of this loop
    filename=${song,,}
    filename=${filename// /_}$userext
    counter=$((counter + 1))

done < "$2"

tracknum=$((tracknum + 1 ))
echo "Almost done... Working on $songname"
    if [ "$userext" = ".mp3" ]; then
        ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" "$filename" 2> /dev/null && 
        eyeD3 -Q --remove-all -a "$artistname" -A "$albumname" -t "$songname" -n "$tracknum" "$filename"
    else
        ffmpeg -nostdin -i "$1" -b:a 320k -ss "$start" "$filename" 2> /dev/null &&
        printf "Artist=%s\nAlbum=%s\nTitle=%s\nTrack=%s" "$artistname" "$albumname" "$songname" "$tracknum" | opustags -i -S "$filename"
    fi

rm "$1" "$2"
