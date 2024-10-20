#!/bin/bash

# Source the configuration file
if [ -f "$HOME/dotfiles/config.env" ]; then
  source "$HOME/dotfiles/config.env"
else
  echo "Error: Configuration file not found."
  exit 1
fi

# Check if the GITHUB_TOKEN variable is set
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set in the configuration file."
  exit 1
fi

# Configure Git to use the PAT for authentication
git config --global credential.helper store
echo "https://$GITHUB_TOKEN:@github.com" > ~/.git-credentials

echo "GitHub authentication configured successfully!"