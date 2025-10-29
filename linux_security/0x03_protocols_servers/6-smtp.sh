#!/bin/bash
grep '^\s*smtpd_tls_security_level' /etc/postfix/main.cf && echo "STARTTLS configured" || echo "STARTTLS not configured"
