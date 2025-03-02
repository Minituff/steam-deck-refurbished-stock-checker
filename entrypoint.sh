#!/bin/bash

install_cron(){
    # Echo the CRON schedule for logging/debugging
    echo "Installing CRON schedule: $CRON_SCHEDULE in TZ: $TZ"

    # Dump the current cron jobs to a temporary file, create the file if it doesn't exist
    crontab -l >tempcron 2>/dev/null || touch tempcron

    # Remove the existing cron job for your backup script from the file
    sed -i '/checker/d' tempcron

    # Add a test job that runs every minute to verify cron is working
    echo "* * * * * echo \"[CRON TEST JOB RAN at \$(date)]\" >> /var/log/cron-debug.log 2>&1" >>tempcron
    
    # Add the main cron job with environment
echo "$CRON_SCHEDULE . /etc/environment; echo \"[CRON JOB STARTED at \$(date)]\" >> /var/log/cron-debug.log; echo \"Running Python script...\" >> /var/log/cron-debug.log; /usr/local/bin/python3 -u /app/checker.py >> /var/log/cron-debug.log 2>&1; echo \"[CRON JOB COMPLETED at \$(date)]\" >> /var/log/cron-debug.log" >>tempcron
    # Install the new cron jobs and remove the tempcron file
    crontab tempcron && rm tempcron
    
    # Print the installed crontab for verification
    echo "Installed crontab:"
    crontab -l
}

# Dump the current environment variables to /etc/environment
printenv | sed 's/^\(.*\)$/export \1/g' > /etc/environment

# Create log files
touch /var/log/cron-debug.log

if [ "${CRON_SCHEDULE_ENABLED,,}" = "true" ]; then
    install_cron
else
    echo "Skipping CRON installation since CRON_SCHEDULE_ENABLED=false"
fi

# Start cron in the foreground to see debug output
echo "Starting cron service..."
service cron start
echo "Cron service started. Status:"
service cron status

if [ "${RUN_ON_START,,}" = "true" ]; then
    echo "Running checker script on start..."
    # Run the checker script once immediately
    /usr/local/bin/python3 /app/checker.py
fi

echo "Container setup complete, waiting for cron jobs to execute..."
# Keep the container running while tailing the debug log
exec tail -f /var/log/cron-debug.log