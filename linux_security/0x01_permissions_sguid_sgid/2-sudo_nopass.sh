#!/bin/bash
echo "$1 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"$1" && chmod 0440 /etc/sudoers.d/"$1"
