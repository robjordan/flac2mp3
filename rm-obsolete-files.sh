#!/bin/bash
export BASE=/media/music

# remove any files from 'portable' which are absent on 'master' (exc mp3/flac)
find $BASE/portable/[0-9A-Z]/ -type f -exec rm-obsolete-files-inner.sh {} \;

