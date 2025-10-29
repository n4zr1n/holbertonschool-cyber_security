#!/bin/bash
grep -qE '^\s*smtpd_tls_security_level\s*=\s*encrypt\b' /etc/postfix/main.cf && echo "STARTTLS configured" || echo "STARTTLS not configured"
