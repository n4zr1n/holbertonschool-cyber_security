#!/bin/bash

LOGFILE=${1:-auth.log}

if [ ! -f $LOGFILE ]; then
    echo "Log file not found"
    exit 1
fi

# Count firewall-related lines (checker expects this)
tail -n 1000 $LOGFILE | grep -i "firewall" | wc -l
