#!/bin/bash

LOGFILE=${1:-auth.log}

if [ ! -f $LOGFILE ]; then
    echo "Log file not found"
    exit 1
fi

# Extract all users created by useradd
grep -i "useradd" "$LOGFILE" \
    | grep -o "name=[^, ]*" \
    | cut -d= -f2 \
    | sort \
    | uniq \
    | paste -sd ","
