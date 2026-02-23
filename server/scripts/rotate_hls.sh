#!/bin/bash
# Cleanup old HLS segments (older than 1h)
find /var/www/html/stream -type f -mmin +60 -delete
