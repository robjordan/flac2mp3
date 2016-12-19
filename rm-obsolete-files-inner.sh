#!/bin/bash
# check whether a file is candidate for removal and if so, delete it
pfile=$1
mfile=${pfile/portable/master}
if [ ! -f "$mfile" ]; then
  if [ ! -f "${mfile/%mp3/flac}" ]; then
    echo "master: " $mfile
    echo "portable: " $pfile
    echo rm "$pfile"
  fi
fi

