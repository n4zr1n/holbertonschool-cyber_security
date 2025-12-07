#!/bin/bash

if [ -z $1 ]
then
    LOGFILE="dmesg"
else
    LOGFILE=$1
fi

if [ ! -f $LOGFILE ]
then
    echo "Log file not found"
    exit 1
fi

grep -m 1 "Linux version" $LOGFILE
