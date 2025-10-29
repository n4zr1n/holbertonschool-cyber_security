#!/bin/bash
val=$(awk -F= '/^\s*smtpd_tls_security_level/ {gsub(/ /,"",$2); print tolower($2); exit}' /etc/postfix/main.cf)
[[ $val == encrypt ]] && echo "STARTTLS configured" || echo "STARTTLS not configured"
