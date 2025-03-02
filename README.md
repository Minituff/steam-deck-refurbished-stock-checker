# Steam Deck Refurbished Stock Checker

## Description

This project provides a script to monitor the availability of refurbished Steam Deck units on the official store page and send a notification to a specified Discord channel when stock is detected. The script uses Selenium for web scraping and a Discord webhook for notifications.

## Alternative Setup with docker and docker compose
```yaml
services:
  steam_deck-notifier:
    container_name: minituff/steam_deck-notifier
    restart: unless-stopped
    environment:
      - DISCORD_WEBHOOK_URL=
      - CRON_SCHEDULE=* * * * * # Every minute
      - TZ=America/Los_Angeles
      - RUN_ON_START=true
      # Comma seperated list
      - PRODUCT_TITLES=Steam Deck 512GB OLED - Valve Certified Refurbished,Steam Deck 1TB OLED - Valve Certified Refurbished 
```

## Disclaimer

This script is provided "as is" for personal use. Be aware of website scraping policies and use responsibly.