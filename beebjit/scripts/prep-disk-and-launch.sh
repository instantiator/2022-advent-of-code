#!/bin/bash


if [ -z "$1" ]
then
    echo "No input file provided - launching without a disk..."
    cd /beebjit
    ./beebjit -fast -opt sound:off,bbc:cycles-per-run=10000000 -terminal -headless

else
    echo "Input file provided - preparing disk 0..."
    RAW_INPUT="/data/$1"
    SSD="/data/disk.ssd"
    BASIC_FILENAME="B.PROGRAM"
    BASIC="/data/$BASIC_FILENAME"

    RAW_BOOT="/data/boot"
    BOOT="/data/!BOOT"

    # prepare BASIC file
    echo "Processing file: $RAW_INPUT"
    tr '\012' '\015' < $RAW_INPUT > $BASIC

    # prepare !BOOT
    echo "Creating !BOOT"
    echo "CHAIN \"$BASIC_FILENAME\"" | tr '\012' '\015' > $BOOT

    # create disk
    rm -f $SSD
    beeb blank_ssd $SSD
    beeb putfile $SSD $BASIC
    beeb putfile $SSD $BOOT
    beeb info $SSD

    # make disk bootable
    beeb opt4 $SSD 3
    beeb title $DSK "BASIC disk"

    cd /beebjit
    ./beebjit -fast -opt sound:off,bbc:cycles-per-run=10000000 -terminal -headless -0 $SSD
fi
