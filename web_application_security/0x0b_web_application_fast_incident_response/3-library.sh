#!/usr/bin/env bash

# Use logs.txt by default if no input file is provided
LOGFILE="${1:-logs.txt}"

# Step 1: Identify attacker IP
ATTACKER_IP=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" \
    | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')

# Step 2: Extract User-Agent strings for that IP
grep "$ATTACKER_IP" "$LOGFILE" \
    | grep -oP '"[^"]+"\s*"[^"]+"\s*"[^"]+"\s*"[^"]+"' \
    | awk -F'"' '{print $(NF-1)}' \
    | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'
