#!/bin/bash
# Convert a FLAC (filename passed as only argument) to MP3.
# Delete input file if successfully converted, but only if path contains "portable"
echo "Converting " $1
mp3file="${1%.*}".mp3
# the command below doesn't transfer tags - no use!
# flac -scd "$1" | lame -V0 - "$mp3file"
# the one below seems better
ffmpeg -y -i "$1" -codec:a libmp3lame -q:a 0 -map_metadata 0 -id3v2_version 3 "$mp3file"
if [ $? -ne 0 ]
then
   echo "something went wrong, return value: " $?
elif [ -s "$mp3file" ]
then
   echo "output file created successfully: " "$mp3file"
   echo "$mp3file" | grep portable > /dev/null
   if [ $? -eq 0 ]
   then
       echo "removing FLAC file: " "$1"
       rm "$1"
   fi
else
   echo "command completed successfully but output file not present"
fi
