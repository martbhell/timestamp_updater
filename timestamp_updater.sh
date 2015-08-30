#!/bin/bash

# https://github.com/martbhell/timestamp_updater
# copying files over MTP (usb cable from my phone to computer) does not make it possible to retain timestamps.
# This script loops through the files and uses "touch -m -a --reference=/old/file /new/file" to update the access and modification time.
# touch -m -a --reference="/run/user/$UID/gvfs/mtp:host=%5Busb%3A002%2C008%5D/Internal storage/DCIM/100ANDRO/DSC_0080.JPG" DSC_0080.JPG
# With a thousands of pictures and NTFS fuse mounted on Ubuntu it takes a while for the fs to come back to normal after running this script.
# Only tested on Ubuntu 15.04 with Sony Xperia Z1 Compact

# Room for improvement - there are scripts to find the path to the MTP device automatically. I'm liking this to be more manual / not so common activity.

usage() {

    echo "Script to modify access/modification timestamp of files to the same as the reference files."
    echo "Set/create sets of OLDDIR/NEWDIR"
    echo "$0 -r # sets the timestamps"
    echo "$0 # not much"
    echo "$0 # with DEBUG=1 inside the script prints the command to stdout"

}

if [ "$1" != "-r" ]; then
    usage
    exit 1
fi

# Set to 1/a number at least..
DEBUG=0

dir1() {

    # NEWDIR1 has files from Internal
    OLDDIR1="/run/user/1000/gvfs/mtp:host=%5Busb%3A002%2C008%5D/Internal storage/DCIM/100ANDRO"
    NEWDIR1="/mnt/3TB1/_BACKUP/20140621-20140810_Z1"

    ## BKP DIR 1
    for file in $(ls $NEWDIR1); do
        OLDFILE="$OLDDIR1/$file"
        NEWFILE="$NEWDIR1/$file"
        if [ -f "$OLDFILE" ]; then
            if [ "$DEBUG" != 0 ]; then
             echo touch -m -a --reference=\"$OLDFILE\" "$NEWFILE"
            fi
            if [ "$1" == "-r" ]; then
             touch -m -a --reference="$OLDFILE" "$NEWFILE"
            fi
        fi
    done

    unset file
    unset OLDFILE
    unset NEWFILE

}

dir23() {
    # Newdir2/3 has files from SD card
    OLDDIR2="/run/user/1000/gvfs/mtp:host=%5Busb%3A002%2C008%5D/SD Card/DCIM/100ANDRO"
    NEWDIR2="/mnt/3TB1/_BACKUP/20140811-20150420_Z1"
    NEWDIR3="/mnt/3TB1/_BACKUP/20150421-20150830_Z1"

    ## BKP DIR 2
    for file in $(ls $NEWDIR2); do
        OLDFILE="$OLDDIR2/$file"
        NEWFILE="$NEWDIR2/$file"
        if [ "$DEBUG" != 0 ]; then
            ls "$OLDFILE"
        fi
        if [ -f "$OLDFILE" ]; then
            if [ "$DEBUG" != 0 ]; then
             echo touch -m -a --reference=\"$OLDFILE\" "$NEWFILE"
            fi
            if [ "$1" == "-r" ]; then
             touch -m -a --reference="$OLDFILE" "$NEWFILE"
            fi
        fi
    done
    unset file
    unset OLDFILE
    unset NEWFILE

    ## BKP DIR 3
    for file in $(ls $NEWDIR3); do
        OLDFILE="$OLDDIR2/$file"
        NEWFILE="$NEWDIR3/$file"
        if [ -f "$OLDFILE" ]; then
            if [ "$DEBUG" != 0 ]; then
             echo touch -m -a --reference=\"$OLDFILE\" "$NEWFILE"
            fi
            if [ "$1" == "-r" ]; then
             touch -m -a --reference="$OLDFILE" "$NEWFILE"
            fi
        fi
    done
    unset file
    unset OLDFILE
    unset NEWFILE
}

dir1
#dir23
