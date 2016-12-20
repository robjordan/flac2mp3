#!/bin/bash

export BASE=/media/music-rw
export lockfile=$BASE/portable/sync-new-files-running

cd $BASE/master
# make a link in 'portable' to any new/changed files in 'master' (exit if another iteration is still running)
if [ -f "$lockfile" ]; then
  exit 1
fi
touch "$lockfile"
find . -type f -newer ../portable/last-updated -print | cpio --quiet -pdmlv ../portable

# rerun the FLAC->mp3 conversion process
find $BASE/portable -name '*.flac' -exec $HOME/bin/flac2mp3.sh {} \;

# finally update the timestamp for next time
mv "$lockfile" $BASE/portable/last-updated
