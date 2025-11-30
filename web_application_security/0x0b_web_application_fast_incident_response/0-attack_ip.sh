#!/usr/bin/env bash
# Find the IP address with the highest number of requests in logs.txt

grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' logs.txt \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -1 \
    | awk '{print $2}'
