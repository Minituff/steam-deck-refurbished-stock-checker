#!/usr/bin/env bash

echo "Installing 'cecho' command..."
WORKSPACE_DIR="/workspaces/steam-deck-refurbished-stock-checker"
dos2unix $WORKSPACE_DIR/.devcontainer/scripts/cecho.sh
ln -s $WORKSPACE_DIR/.devcontainer/scripts/cecho.sh /usr/bin/cecho
chmod +x /usr/bin/cecho

cecho CYAN "Installing 'sd' command..."
dos2unix $WORKSPACE_DIR/.devcontainer/scripts/sd.sh
ln -s $WORKSPACE_DIR/.devcontainer/scripts/sd.sh /usr/bin/sd
chmod +x /usr/bin/sd


cecho CYAN "Installing python packages (for api)..."
python3 -m pip install -r $WORKSPACE_DIR/requirements-dev.txt



cecho CYAN "Adding aliases (for convenience)..."
for file in ~/.zshrc ~/.bashrc; do
    echo "alias home=\"cd $WORKSPACE_DIR\"" >> "$file"
    echo "alias cls=\"clear\"" >> "$file"
done

echo 'DISABLE_UPDATE_PROMPT=true  # Auto update ohmyzsh and dont ask' >> ~/.zshrc

# cecho CYAN "Installing python packages (for docs)..."
# python3 -m pip install -r $WORKSPACE_DIR/docs/requirements.txt

cecho CYAN "Handling locales..."
echo "export LANG=en_US.UTF-8" >> ~/.zshrc; 
LC_CTYPE=en_US.UTF-8
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen

# Test commands
sd --help

cecho CYAN "Installing pre-commit hooks..."
pre-commit install 

cecho "GREEN" "Success!! Development enviornment ready to go!!"
cecho "GREEN" "Use the command 'sd --help' to get started."


exit 0
# No need to 'source ~/.zshrc' since the terminal won't be open yet
