#!/bin/bash
sudo nmap --packet-flags ALL -p$2 -oN custom_scan.txt $1 2>&1
