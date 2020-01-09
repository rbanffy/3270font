#!/bin/sh

# Gets the current branch README, selects the camo cache images and
# purges the cache so that new versions of the images can be seen.

curl -s https://github.com/rbanffy/3270font/blob/\
"$(git rev-parse --abbrev-ref HEAD)"\
/README.md \
    | grep -F 'camo.githubusercontent.com/' \
    | sed 's/\(^<p>.*href="\)//' \
    | sed 's/\(">.*\)//' \
    | while read -r i
do
    echo Cleaning $i
    curl -X PURGE "$i"
done
