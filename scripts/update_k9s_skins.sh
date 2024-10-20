#!/bin/bash

# Source the configuration file
CONFIG_FILE="$HOME/dotfiles/config.env"
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
else
  echo "Error: Configuration file not found: $CONFIG_FILE"
  exit 1
fi

# Directory to store the skin files
SKINS_DIR="$HOME/.k9s/skins"

# GitHub repository and branch for k9s themes
REPO="derailed/k9s"
BRANCH="master"

# GitHub repository and branch for Catppuccin themes
CATPPUCCIN_REPO="catppuccin/k9s"
CATPPUCCIN_BRANCH="main"

# Skin files to download from k9s repository
SKINS=(
  "dracula.yml"
  "monokai.yml"
  "nord.yml"
  "one-dark.yml"
  "solarized-dark.yml"
)

# Catppuccin themes to download
CATPPUCCIN_SKINS=(
  "catppuccin-latte.yml"
  "catppuccin-frappe.yml"
  "catppuccin-macchiato.yml"
  "catppuccin-mocha.yml"
  "catppuccin-latte-transparent.yml"
  "catppuccin-frappe-transparent.yml"
  "catppuccin-macchiato-transparent.yml"
  "catppuccin-mocha-transparent.yml"
)

# Create the skins directory if it doesn't exist
mkdir -p "$SKINS_DIR"

# Function to download a file using the GitHub API
download_with_api() {
  local url=$1
  local output=$2
  curl -sL -H "Authorization: token $GITHUB_TOKEN" "$url" -o "$output"
}

# Function to download a file using raw URLs
download_with_raw() {
  local url=$1
  local output=$2
  curl -sL "$url" -o "$output"
}

# Download each skin file from k9s repository
for SKIN in "${SKINS[@]}"; do
  SKIN_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/skins/$SKIN"
  if [ -n "$GITHUB_TOKEN" ]; then
    API_URL="https://api.github.com/repos/$REPO/contents/skins/$SKIN?ref=$BRANCH"
    download_with_api "$API_URL" "$SKINS_DIR/$SKIN"
  else
    download_with_raw "$SKIN_URL" "$SKINS_DIR/$SKIN"
  fi
done

# Download each Catppuccin theme
for SKIN in "${CATPPUCCIN_SKINS[@]}"; do
  SKIN_URL="https://raw.githubusercontent.com/$CATPPUCCIN_REPO/$CATPPUCCIN_BRANCH/$SKIN"
  if [ -n "$GITHUB_TOKEN" ]; then
    API_URL="https://api.github.com/repos/$CATPPUCCIN_REPO/contents/$SKIN?ref=$CATPPUCCIN_BRANCH"
    download_with_api "$API_URL" "$SKINS_DIR/$SKIN"
  else
    download_with_raw "$SKIN_URL" "$SKINS_DIR/$SKIN"
  fi
done

echo "k9s skins updated successfully!"