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

# Extract last 1000 lines
tail -n 1000 $LOGFILE | grep "Failed password" | awk '{print $9}' | sort | uniq -c > /tmp/failed.txt
tail -n 1000 $LOGFILE | grep "Accepted password" | awk '{print $9}' | sort | uniq > /tmp/success.txt

# Find user that appears in both lists
while read count user
do
    grep -q "^$user$" /tmp/success.txt
    if [ $? -eq 0 ]
    then
        echo $user
        exit 0
    fi
done < /tmp/failed.txt
