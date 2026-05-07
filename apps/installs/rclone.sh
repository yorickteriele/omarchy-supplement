#!/bin/sh
set -e

yay -S --noconfirm --needed rclone fuse3

REMOTE="gdrive"
MOUNT_DIR="$HOME/gdrive"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SERVICE_DIR/rclone-${REMOTE}.service"

if ! rclone listremotes | grep -q "^${REMOTE}:"; then
  echo "No Google Drive remote found."
  rclone config
fi

mkdir -p "$MOUNT_DIR"
mkdir -p "$SERVICE_DIR"

cat >"$SERVICE_FILE" <<EOF
[Unit]
Description=Mount Google Drive with rclone
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/rclone mount ${REMOTE}: ${MOUNT_DIR} \\
  --vfs-cache-mode writes \\
  --dir-cache-time 72h \\
  --poll-interval 15s
ExecStop=/bin/fusermount3 -u ${MOUNT_DIR}
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now "rclone-${REMOTE}.service"

echo "Google Drive mounted at: $MOUNT_DIR"
echo "Service enabled: rclone-${REMOTE}.service"
