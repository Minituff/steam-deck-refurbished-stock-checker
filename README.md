# Steam Deck Refurbished Stock Checker

<div align="center">
  <a href="#"><img width="400"/></a>

Get notified on Discord when a refurbished Steam Deck is back in stock!
<br>

  [![Pulls from DockerHub](https://img.shields.io/docker/pulls/minituff/steam-deck-refurbished-stock-checker?logo=docker)](https://hub.docker.com/r/minituff/steam-deck-refurbished-stock-checker)
  [![Docker Image Version (latest semver)](https://img.shields.io/docker/v/minituff/steam-deck-refurbished-stock-checker/latest?label=latest%20version)](https://hub.docker.com/r/minituff/steam-deck-refurbished-stock-checker)
  [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/minituff/steam-deck-refurbished-stock-checker/latest?label=size)](https://hub.docker.com/r/minituff/steam-deck-refurbished-stock-checker)



</div>

## Description

This project provides a script to monitor the availability of refurbished Steam Deck units on the official store page and send a notification to a specified Discord channel when stock is detected. The script uses Selenium for web scraping and a Discord webhook for notifications.

![screenshot=t](media/screenshot.png)

## Setup with Docker compose
```yaml
services:
  steam_deck-notifier:
    image: minituff/steam-deck-refurbished-stock-checker
    container_name: steam_deck-notifier
    hostname: steam_deck-notifier
    restart: unless-stopped
    environment:
      - DISCORD_WEBHOOK_URL=
      - CRON_SCHEDULE=*/5 * * * * # Every 5 minutess
      - TZ=America/Los_Angeles
      - RUN_ON_START=false
      # Comma seperated list from https://store.steampowered.com/sale/steamdeckrefurbished
      - PRODUCT_TITLES=Steam Deck 512GB OLED - Valve Certified Refurbished,Steam Deck 1TB OLED - Valve Certified Refurbished 
```
## Discord Webook URL
This can be obtained by following these steps in your Discord server:
* `Server settings` -> `Apps` -> `Integrations` -> `Webhooks` -> `New Webook` *Name it* -> `Copy Webhook URL`

## Disclaimer

This script is provided "as is" for personal use. Be aware of website scraping policies and use responsibly.