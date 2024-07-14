#!/bin/bash

set -eu

source .env

config_file=overleaf.rc

if [ ! -d "$INSTALLATION_DIR" ]; then
	git clone https://github.com/overleaf/toolkit.git $INSTALLATION_DIR
	cd $INSTALLATION_DIR/config
	bin/init
else
	cd $INSTALLATION_DIR/config
fi

if [ -n "$OVERLEAF_LISTEN_IP" ]; then
	sed -i "s/^OVERLEAF_LISTEN_IP=.*/OVERLEAF_LISTEN_IP=${OVERLEAF_LISTEN_IP}/" "$config_file"
fi
if [ -n "$OVERLEAF_PORT" ]; then
    sed -i "s/^OVERLEAF_PORT=.*/OVERLEAF_PORT=${OVERLEAF_PORT}/" "$config_file"
fi
if [ -n "$NGINX_HTTP_LISTEN_IP" ]; then
    sed -i "s/^NGINX_HTTP_LISTEN_IP=.*/NGINX_HTTP_LISTEN_IP=${NGINX_HTTP_LISTEN_IP}/" "$config_file"
fi
