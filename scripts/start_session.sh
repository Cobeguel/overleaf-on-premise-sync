#!/bin/bash

set -eu

source .env

URL="http://${NGINX_HTTP_LISTEN_IP}:${OVERLEAF_PORT}"
RESPONSE=$(curl -s -c cookies.txt $URL/login)
CSRF_TOKEN=$(echo "$RESPONSE" | grep -oP '(?<=name="_csrf" type="hidden" value=").*?(?=")')
curl -b cookies.txt -c cookies.txt -d "_csrf=$CSRF_TOKEN&email=$OVERLEAF_USER&password=$OVERLEAF_PASSWORD" $URL/login
