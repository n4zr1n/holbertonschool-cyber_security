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

# Count unique IPs of successful SSH logins
tail -n 1000 $LOGFILE | grep "Accepted password" | awk '{print $11}' \
    | sort | uniq | wc -l
