#!/bin/bash
lynis audit system --quiet | grep -E "Warning|Vulnerability|Suggestion"
