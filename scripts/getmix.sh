#!/bin/sh
# !!!Might need to switch to youtube-dlp!!!
# First argument = youtube mix link
# Second argument = 00:00:00 $artistname,$songname
# Artist and song name can not have a forward slash in the name,
# change it to a backslash

yt-dlp -o "$HOME/music/album.%(ext)s" --extract-audio --audio-format mp3 "$1"

while read -r time song; do
    [ -n "$start" ] && 
        echo "Working on $songname..."
        ffmpeg -nostdin -i "$HOME/music/album.mp3" -b:a 320k -ss "$start" -to "$time" "$HOME/music/$fileartistname/$filename" && 
        eyeD3 -Q --remove-all -a "$artistname" -t "$songname" "$HOME/music/$fileartistname/$filename" 1> /dev/null
    start="$time"

    artistname=$(echo "$song" | cut -d ',' -f1)
    fileartistname=$(echo "$artistname" | tr '[:upper:]' '[:lower:]' | tr '[:blank:]' '_')
    ! [ -e "$HOME/music/$fileartistname" ] && mkdir "$HOME/music/$fileartistname"

    songname=$(echo "$song" | cut -d ',' -f2)
    filename=$(echo "$song" | cut -d ',' -f2 | tr '[:upper:]' '[:lower:]' | tr '[:blank:]' '_' ).mp3
    [ -e "$HOME/music/$fileartistname/$filename" ] && { echo "That song name already exists" ; exit 1 ;}

done < "$2"

echo "Almost done... Working on $songname..."
echo "$start $filename"
ffmpeg -nostdin -i "$HOME/music/album.mp3" -b:a 320k -ss "$start" "$HOME/music/$fileartistname/$filename"
eyeD3 -Q --remove-all -a "$artistname" -t "$songname" "$HOME/music/$fileartistname/$filename"
