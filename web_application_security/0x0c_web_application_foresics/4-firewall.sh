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

# Count all firewall additions
tail -n 1000 $LOGFILE | grep -iE "iptables.*-A|ufw allow" | wc -l
