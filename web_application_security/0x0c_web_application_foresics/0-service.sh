#!/bin/bash

# Check if argument was provided
if [ -z $1 ]
then
    echo "Usage: $0 <logfile>"
    exit 1
fi

LOGFILE=$1

# Check if file exists
if [ ! -f $LOGFILE ]
then
    echo "Log file not found"
    exit 1
fi

# Extract service names (example: sshd[1234] -> sshd)
grep -Eo '[a-zA-Z0-9_-]+\[[0-9]\+\]' $LOGFILE | \
    sed 's/\[[0-9]\+\]//' | \
    sort | \
    uniq -c | \
    sort -nr
