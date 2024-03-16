#!/bin/zsh

# Define the path to the dot files directory
DOTFILES_DIR="$HOME/.dotfiles"

# Read the configuration file listing dot files and their paths
while IFS= read -r line; do
    # Split each line into dot file and target path
    dotfile=$(echo $line | cut -d ' ' -f 1)
    target_path=$(echo $line | cut -d ' ' -f 2)

    # Create symbolic link from dot files directory to home directory
    ln -s "$DOTFILES_DIR/$dotfile" "$HOME/$target_path"
done < "$HOME/.dotfiles/install.conf"

echo "Symbolic links created successfully."
