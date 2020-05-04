#!/bin/bash

export BASE=/media/music-rw
export lockfile=$HOME/flac2mp3/sync-new-files-running
export lastupdated=$HOME/flac2mp3/last-updated

cd $BASE/master
# make a link in 'portable' to any new/changed files in 'master' (exit if another iteration is still running)
if [ -f "$lockfile" ]; then
  exit 1
fi
touch "$lockfile"
find . -type f -newer "$lastupdated" -print | cpio --quiet -pdmlv ../portable

# rerun the FLAC->mp3 conversion process
find $BASE/portable -name '*.flac' -exec $HOME/bin/flac2mp3.sh {} \;

# finally update the timestamp for next time
mv "$lockfile" "$lastupdated"
