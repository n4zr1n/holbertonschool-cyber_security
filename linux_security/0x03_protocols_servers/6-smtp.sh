#!/bin/bash
grep -qE '^[[:space:]]*smtpd_tls_security_level[[:space:]]*=[[:space:]]*encrypt' /etc/postfix/main.cf && echo "STARTTLS configured" || echo "STARTTLS not configured"
