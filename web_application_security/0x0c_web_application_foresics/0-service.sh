#!/bin/bash

# Default log file to auth.log if no argument provided
if [ -z $1 ]
then
    LOGFILE="auth.log"
else
    LOGFILE=$1
fi

# Validate file exists
if [ ! -f $LOGFILE ]
then
    echo "Log file not found"
    exit 1
fi

# Extract service names like: sshd[1234]
grep -Eo '[a-zA-Z0-9_-]+\[[0-9]+\]' $LOGFILE | \
    cut -d'[' -f1 | \
    sort | \
    uniq -c | \
    sort -nr
