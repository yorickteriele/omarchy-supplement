#!/bin/sh

# Install tmux if not already present
yay -S --noconfirm --needed tmux

# Ensure dotfiles are installed/stowed
./dotfiles/install.sh
