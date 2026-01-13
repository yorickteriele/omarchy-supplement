#!/bin/sh

# Apps
echo "Starting App Installation"
./apps/install.sh
echo "Starting App Removal"

# Webapps
echo "Starting Webapps Installation"
./webapps/install.sh

echo "Starting Webapps Removal"
./webapps/remove.sh

# Syncing the Submodules
git submodule update --init --recursive
git submodule foreach 'git fetch && git checkout main && git pull'

# Setup configuration
echo "Starting Configuration"


