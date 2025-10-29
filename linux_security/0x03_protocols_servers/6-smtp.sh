#!/bin/bash
TLS=$(grep -E '^\s*smtpd_tls_security_level\s*=' /etc/postfix/main.cf | awk -F'=' '{print $2}' | xargs); [[ -z "$TLS" ]] && echo "STARTTLS not configured" || echo "smtpd_tls_security_level = $TLS"
