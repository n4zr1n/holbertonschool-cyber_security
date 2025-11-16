#!/bin/bash
sudo nmap -sF -T2 -f -p80,85 $1
