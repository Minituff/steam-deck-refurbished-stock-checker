#!/bin/bash
. /etc/environment
cd /app
/usr/local/bin/python3 -u /app/checker.py >> /var/log/cron.log 2>&1