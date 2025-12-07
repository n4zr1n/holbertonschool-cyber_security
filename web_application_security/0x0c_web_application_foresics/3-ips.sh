#!/bin/bash

if [ -z $1 ]
then
    LOGFILE="auth.log"
else
    LOGFILE=$1
fi

if [ ! -f $LOGFILE ]
then
    echo "Log file not found"
    exit 1
fi

# Extract unique IPs that successfully logged in
tail -n 1000 $LOGFILE \
    | grep "Accepted" \
    | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" \
    | sort \
    | uniq \
    | wc -l
