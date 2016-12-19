#!/bin/bash
# list all tags from source FLAC and prepare commands for kid3 to apply them to MP3
# ABANDONED: Too much trouble with apostrophes, commas, etc
lltag -S "$*" | awk '
  BEGIN {options="-T --id3v2"}
  /^\/media/ {outfilename=$0; sub("flac:$", "mp3", outfilename);sub("/master/","/portable/",outfilename)}
  /ENCODER/ {next}
  /=/ {
    split($0, bits, "=");
    gsub("'\''", "", bits[2])
    cmd = sprintf(" -c \" set %s '\''%s'\'' \"  ", bits[1], bits[2])
    cmds = cmds cmd
  }
  END {
    printf("kid3-cli %s \"%s\" \n", cmds, outfilename)
  }'