#!/bin/sh

LOGFILE="${1:-logs.txt}"

# Step 1: find attacker IP
ATTACKER_IP=$(grep -o '[0-9]\{1,3\}\(\.[0-9]\{1,3\}\)\{3\}' "$LOGFILE" \
    | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')

# Step 2: extract User-Agent strings for this IP
grep "$ATTACKER_IP" "$LOGFILE" \
    | awk -F\" '{print $(NF-1)}' \
    | sort | uniq -c | sort -nr | head -1 \
    | awk '{print $2}'
