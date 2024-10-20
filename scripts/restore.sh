#!/bin/bash

# Directory where the backup is stored
BACKUP_DIR="$HOME/dotfiles_backup"

# List of dotfiles to restore
FILES=(
  ".bashrc"
  ".vimrc"
  ".tmux.conf"
  ".config/fish/config.fish"
  ".zshrc"
)

# Copy each file from the backup directory to the home directory
for FILE in "${FILES[@]}"; do
  if [ -f "$BACKUP_DIR/$FILE" ] || [ -d "$BACKUP_DIR/$FILE" ]; then
    cp -r "$BACKUP_DIR/$FILE" "$HOME/"
    echo "Restored $FILE from $BACKUP_DIR"
  else
    echo "Backup for $FILE does not exist, skipping..."
  fi
done

echo "Restore completed successfully!"