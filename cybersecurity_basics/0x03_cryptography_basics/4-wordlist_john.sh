#!/bin/bash
touch 4-password.txt; john --wordlist=/usr/share/wordlists/rockyou.txt "$1" >/dev/null 2>&1 || true; john --show "$1" | cut -d: -f2- > 4-password.txt
