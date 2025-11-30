#!/bin/sh

LOGFILE="${1:-logs.txt}"

# 1. Identify attacker IP
ATTACKER_IP=$(grep -o '[0-9]\{1,3\}\(\.[0-9]\{1,3\}\)\{3\}' "$LOGFILE" \
    | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')

# 2. Extract User-Agent (4th quoted field)
grep "$ATTACKER_IP" "$LOGFILE" \
    | awk -F\" '{print $6}' \
    | sort | uniq -c | sort -nr \
    | head -1 | awk '{print $2}'
