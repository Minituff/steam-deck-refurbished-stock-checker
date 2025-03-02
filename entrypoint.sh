#!/bin/bash

install_cron(){
    # Echo the CRON schedule for logging/debugging
    echo "Installing CRON schedule: $CRON_SCHEDULE in TZ: $TZ"

    # Dump the current cron jobs to a temporary file, create the file if it doesn't exist
    crontab -l >tempcron 2>/dev/null || touch tempcron

    # Remove the existing cron job for your backup script from the file
    sed -i '/checker/d' tempcron

    # Add the new cron job to the file, redirecting output to a log file
    echo "$CRON_SCHEDULE /usr/local/bin/python3 /app/checker.py >> /var/log/cron.log 2>&1" >>tempcron

    # Install the new cron jobs and remove the tempcron file
    crontab tempcron && rm tempcron
}

if [ "${CRON_SCHEDULE_ENABLED,,}" = "true" ]; then
    install_cron
else
    echo "Skipping CRON installation since CRON_SCHEDULE_ENABLED=false"
fi

# Create the log file if it doesn't exist
touch /var/log/cron.log

# Start cron in the background
cron

if [ "${RUN_ON_START,,}" = "true" ]; then
    # Run the checker script once immediately
    /usr/local/bin/python3 /app/checker.py
fi

# Tail the cron log file to keep the container running and output logs to the console
tail -f /var/log/cron.log