#!/bin/bash

export BASE=/media/music

cd $BASE/master
# make a link in 'portable' to any new/changed files in 'master'
touch $BASE/portable/this-update
find . -type f -newer ../portable/last-updated -print | cpio -pdmlv ../portable

# rerun the FLAC->mp3 conversion process
find $BASE/portable -name '*.flac' -exec flac2mp3.sh {} \;

# finally update the timestamp for next time
mv $BASE/portable/this-update $BASE/portable/last-updated
