#/bin/bash
# List the tag keywords (not values) in a media file
lltag -S "$*" | awk -F'=' '/^ / {print $1}'

