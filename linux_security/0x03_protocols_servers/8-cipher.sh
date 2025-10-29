#!/bin/bash
sudo nmap --script ssl-enum-ciphers -p 443 $1 | grep -E 'Weak|TLS_|CIPHER'
