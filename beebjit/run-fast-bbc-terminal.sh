#!/bin/bash

set -e
set -o pipefail

if [ -z "$1" ]
then
    FILENAME=
else
    FILENAME=$(basename $1)
    TEMP=$(mktemp -d)
    cp $1 $TEMP/$FILENAME
fi

docker run --rm -it -v $TEMP:/data beebjit $FILENAME
