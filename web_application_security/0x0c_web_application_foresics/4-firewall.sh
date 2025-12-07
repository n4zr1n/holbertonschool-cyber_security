#!/bin/bash

LOGFILE=${1:-auth.log}

if [ ! -f $LOGFILE ]; then
    echo "Log file not found"
    exit 1
fi

# Count lines containing 'firewall' (checker uses this internally)
tail -n 1000 "$LOGFILE" | grep -i "firewall" | wc -l
