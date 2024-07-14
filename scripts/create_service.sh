#!/bin/bash

set -eu
source .env

SERVICE_NAME="overleaf-on-premise"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"
SERVICE_EXEC=$INSTALLATION_DIR/bin/up
SERVICE_CONTENT="[Unit]
Description=On premise Overleaf deployment
After=docker.service
Requires=docker.service

[Service]
Type=simple
User=$USER
ExecStart=$SERVICE_EXEC
StandardOutput=null
Restart=on-failure

[Install]
WantedBy=multi-user.target"

echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_FILE" > /dev/null
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl start "$SERVICE_NAME"
echo "Service $SERVICE_NAME created and started."