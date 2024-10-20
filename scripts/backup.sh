#!/bin/bash

# Directory to store the backup
BACKUP_DIR="$HOME/dotfiles_backup"

# List of dotfiles to backup
FILES=(
  ".bashrc"
  ".vimrc"
  ".tmux.conf"
  ".config/fish/config.fish"
  ".zshrc"
)

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy each file to the backup directory
for FILE in "${FILES[@]}"; do
  if [ -f "$HOME/$FILE" ] || [ -d "$HOME/$FILE" ]; then
    cp -r "$HOME/$FILE" "$BACKUP_DIR/"
    echo "Backed up $FILE to $BACKUP_DIR"
  else
    echo "File $FILE does not exist, skipping..."
  fi
done

echo "Backup completed successfully!"