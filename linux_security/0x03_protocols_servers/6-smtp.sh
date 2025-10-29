#!/bin/bash
sudo netstat | grep smtp && echo "STARTTLS configured" || echo "STARTTLS not configured"
