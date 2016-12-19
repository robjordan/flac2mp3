#!/bin/bash
# Just an example of how we can wrap a find command around the flac2mp3 conversion utility
find "/media/music-rw/portable/A" -name '*.flac' -exec flac2mp3.sh {} \;


