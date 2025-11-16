#!/bin/bash
sudo nmap -scanflags -p$2 -oN custom_scan.txt $1 2>&1
