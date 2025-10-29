#!/bin/bash
val=$(awk -F= '/^\s*smtpd_tls_security_level/ {gsub(/ /,"",$2); print $2; exit}' /etc/postfix/main.cf 2>/dev/null); [[ "$val" == "encrypt" ]] && echo "STARTTLS configured: $val" || echo "STARTTLS not configured"
