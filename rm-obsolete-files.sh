#!/bin/bash
export BASE=/media/music-rw

# prevent two instances running at once
export lockfile=$BASE/portable/rm-obsolete-files-running
trap "rm $lockfile; exit" SIGHUP SIGINT SIGTERM
if [ -f "$lockfile" ]; then
  exit 1
fi
touch "$lockfile"


# remove any files from 'portable' which are absent on 'master' (exc mp3/flac)
find $BASE/portable/[0-9A-Z]/ -type f -exec $HOME/bin/rm-obsolete-files-inner.sh {} \;

rm "$lockfile"
