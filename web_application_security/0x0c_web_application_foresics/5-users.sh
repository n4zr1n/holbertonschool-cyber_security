#!/bin/bash

LOGFILE=${1:-auth.log}

if [ ! -f $LOGFILE ]; then
    echo "Log file not found"
    exit 1
fi

# Extract created users
tail -n 1000 $LOGFILE \
    | grep -i "useradd" \
    | grep -o "name=[^, ]*" \
    | cut -d= -f2 \
    | sort \
    | uniq \
    | paste -sd ","
