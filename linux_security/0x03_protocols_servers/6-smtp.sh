#!/bin/bash
grep smtpd_tls_security_level && echo "STARTTLS configured" || echo "STARTTLS not configured"
