#!/bin/bash

install_cron(){
    # Echo the CRON schedule for logging/debugging
    echo "Installing CRON schedule: $CRON_SCHEDULE in TZ: $TZ"

    # Dump the current cron jobs to a temporary file, create the file if it doesn't exist
    crontab -l >tempcron 2>/dev/null || touch tempcron

    # Remove the existing cron job for your backup script from the file
    sed -i '/checker\|cron-wrapper/d' tempcron

    # Add the main cron job using the wrapper script
    echo "$CRON_SCHEDULE /app/cron-wrapper.sh" >>tempcron
    
    # Install the new cron jobs and remove the tempcron file
    crontab tempcron && rm tempcron
    
    # Print the installed crontab for verification
    echo "Installed crontab:"
    crontab -l
}

# Dump the current environment variables to /etc/environment
printenv | sed 's/^\(.*\)$/export \1/g' > /etc/environment

# Create log files
touch /var/log/cron.log
chmod 666 /var/log/cron.log  # Make sure log is writable

if [ "${CRON_SCHEDULE_ENABLED,,}" = "true" ]; then
    install_cron
else
    echo "Skipping CRON installation since CRON_SCHEDULE_ENABLED=false"
fi

# Start cron in the foreground to see debug output
service cron start

if [ "${RUN_ON_START,,}" = "true" ]; then
    echo "Running checker script on start..."
    # Run the checker script once immediately
    /usr/local/bin/python3 /app/checker.py
fi

echo "Container setup complete, waiting for cron jobs to execute..."
# Keep the container running while tailing the debug log
exec tail -f /var/log/cron.log