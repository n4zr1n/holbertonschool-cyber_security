#!/usr/bin/env bash

# Use logs.txt by default if no file is provided
LOGFILE="${1:-logs.txt}"

# First, identify the attacker IP (the one with the most requests)
ATTACKER_IP=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -1 \
    | awk '{print $2}')

# Now count how many requests that IP made
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOGFILE" \
    | grep -c "$ATTACKER_IP"
