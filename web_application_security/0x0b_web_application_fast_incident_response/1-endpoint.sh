#!/usr/bin/env bash
# Identify the most requested endpoint in logs.txt

grep -oE '"(GET|POST|PUT|DELETE|HEAD|OPTIONS) [^"]+"' logs.txt \
    | awk '{print $2}' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -1 \
    | awk '{print $2}'
