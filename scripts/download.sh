#!/bin/bash

set -eu

if [ "$#" -ne 1 ]; then
    echo "Use: $0 <project_name>"
    exit 1
fi

source .env
./scripts/validate_session.sh

URL="http://${NGINX_HTTP_LISTEN_IP}:${OVERLEAF_PORT}"
PROJECT=$1

ID=$(./scripts/sqlite_kv.sh get_by_name $PROJECT)

if [ -z "$ID" ]; then
    echo "Project not found"
    exit 1
fi

mkdir -p tmp/$PROJECT
curl -b cookies.txt $URL/project/$ID/download/zip --output tmp/$PROJECT/$PROJECT.zip
unzip -o tmp/$PROJECT/$PROJECT.zip -d tmp/$PROJECT
rm tmp/$PROJECT/$PROJECT.zip

echo "Downloaded project $PROJECT"