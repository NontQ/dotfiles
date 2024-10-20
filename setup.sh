#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Path to your dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# Check if config.env exists, if not, prompt the user to create it from the template
CONFIG_FILE="$DOTFILES_DIR/config.env"
TEMPLATE_FILE="$DOTFILES_DIR/config.env.template"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file not found. Please create $CONFIG_FILE from $TEMPLATE_FILE."
  exit 1
fi

# Source the configuration file
source "$CONFIG_FILE"

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
  if ! command_exists brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo "Homebrew is already installed."
  fi
}

# Function to install Git
install_git() {
  if ! command_exists git; then
    echo "Installing Git..."
    brew install git
  else
    echo "Git is already installed."
  fi
}

# Function to install chezmoi
install_chezmoi() {
  if ! command_exists chezmoi; then
    echo "Installing chezmoi..."
    brew install chezmoi
  else
    echo "chezmoi is already installed."
  fi
}

# Function to install essential packages
install_packages() {
  echo "Installing essential packages..."
  brew install curl vim tmux fish starship
}

# Function to install Homebrew packages from Brewfile
install_brewfile_packages() {
  if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
  else
    echo "Warning: Brewfile not found. Skipping Brewfile installation."
  fi
}

# Function to set up Fish shell
setup_fish() {
  if command_exists fish; then
    echo "Setting up Fish shell..."
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fish -c "fisher update"
  else
    echo "Fish shell is not installed."
  fi
}

# Function to set up Git configuration
setup_git() {
  echo "Setting up Git configuration..."
  git config --global user.name "$GITHUB_USER"
  git config --global user.email "$GITHUB_EMAIL"
  git config --global credential.helper "cache --timeout=3600"
}

# Function to initialize and apply chezmoi configuration
setup_chezmoi() {
  echo "Setting up chezmoi..."
  chezmoi init --apply "$REPO_URL"
}

# Function to apply environment-specific configurations
apply_environment_configs() {
  echo "Applying environment-specific configurations..."
  task apply-common-configs
  if [[ "$OSTYPE" == "darwin"* ]]; then
    task apply-macos-configs
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    task apply-linux-configs
  fi
}

# Main function
main() {
  install_homebrew
  install_git
  install_chezmoi
  install_packages
  install_brewfile_packages
  setup_fish
  setup_git
  setup_chezmoi
  apply_environment_configs
  echo "Setup completed successfully!"
}

main