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

tail -n 1000 $LOGFILE | grep -i "firewall" | wc -l
