#!/bin/bash
find "$1" -type f -perm /2000 -print 2>/dev/null
