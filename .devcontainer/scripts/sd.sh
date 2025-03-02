#!/usr/bin/env bash

# Function to display help information
show_help() {
    cecho CYAN "SteadDeck Developer Commands:"
    echo "  build          - Build container"

}

APP_HOME="/workspaces/steam-deck-refurbished-stock-checker"
export APP_HOME

# Function to execute commands
execute_command() {
    case $1 in
    build)
        clear
        cecho CYAN "Building ..."
        cd $APP_HOME
        ;;
    pytest)
        cd $APP_HOME
        clear
        cecho CYAN "Running Pytest..."
        python3 -m pytest --cov app --cov-report html --cov-report term
        ;;
    docs)
        cd $APP_HOME
        clear
        cecho CYAN "Running documentation locally..."
        python3 -m mkdocs serve
        ;;
    format)
        cd $APP_HOME
        clear
        cecho CYAN "Formatting Python code with Black..."
        python3 -m black --line-length 120 app tests
        ;;
    *)
        cecho RED "Unknown command: $1"
        show_help
        # echo "Use 'nb --help' for a list of available commands."
        ;;
    esac
}

# Check for --help argument
if [ -z "$1" ] || [ "$1" == "--help" ]; then
    show_help
else
    execute_command "$1"
fi
