#!/bin/sh

# Apps
echo "Starting App Installation"
./apps/install.sh

echo "Starting App Removal"
./apps/remove.sh

# Omarchy plugins
echo "Starting Omarchy Plugin Installation"
./omarchy-plugins/install.sh

# Webapps
echo "Starting Webapps Installation"
./webapps/install.sh

echo "Starting Webapps Removal"
./webapps/remove.sh
# Syncing the Submodules
./update-repos.sh

# Setup configuration
echo "Starting Configuration"
./dotfiles/install.sh
hyprctl reload
