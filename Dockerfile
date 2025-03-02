FROM python:3.10

# Install system dependencies
RUN apt-get update && apt-get install -y \
    chromium-driver \
    curl \
    nano \
    bash \
    cron && \
    rm -rf /var/lib/apt/lists/*

# Set working directory

# Copy requirements file && Install dependencies using pip as root (default user)
COPY requirements.txt /app/
RUN python3 -m pip install --no-cache-dir -r /app/requirements.txt

# Copy application files
COPY checker.py /app/
COPY --chmod=7777 cron-wrapper.sh /app/
COPY --chmod=7777 entrypoint.sh /entrypoint.sh

ENV \
    # Print to console
    PYTHONUNBUFFERED=1 \
    # Set the default timezone
    TZ="Etc/UTC" \
    # Set the default cron schedule
    CRON_SCHEDULE="*/5 * * * *" \
    # Set python path
    PYTHONPATH=".:/app" \
    # Set the default cron schedule enabled
    CRON_SCHEDULE_ENABLED=true \
    APP_VERSION="0.0.0"

LABEL \
    org.opencontainers.image.source="https://github.com/Minituff/steam-deck-refurbished-stock-checker" \
    org.opencontainers.image.title="Refurbished Steam Deck Notifier" \
    org.opencontainers.image.description="Refurbished Steam Deck Notifier" \
    org.opencontainers.image.authors="James Tufarelli" \
    org.opencontainers.image.source="https://github.com/Minituff/steam-deck-refurbished-stock-checker" \
    org.opencontainers.image.licenses="MIT"
    
# Run the entrypoint script
ENTRYPOINT ["bash", "/entrypoint.sh"]
