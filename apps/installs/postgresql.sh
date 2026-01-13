#!/bin/bash

yay -S --noconfirm --needed postgresql

if [ ! -d "/var/lib/postgres/data" ] || [ -z "$(ls -A /var/lib/postgres/data 2>/dev/null)" ]; then
    echo "Initializing PostgreSQL database..."
    sudo -u postgres initdb -D /var/lib/postgres/data --locale=C.UTF-8 --encoding=UTF8 --data-checksums
else
    echo "PostgreSQL data directory already initialized, skipping..."
fi

echo "Starting PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql
