#!/bin/bash
# list all tags from source FLAC and prepare commands for kid3 to apply them to MP3
lltag -S "$*" | awk '
  BEGIN {options="-T --id3v2"}
  /^\/media/ {outfilename=$0; sub("flac:$", "mp3", outfilename);sub("/master/","/portable/",outfilename)}
  /ENCODER/ {next}
  /=/ {split($0, bits, "=");
      printf("kid3-cli -c \" set %s '\''%s'\'' \"  \"%s\" \n", bits[1], bits[2], outfilename)}
  END {}'
