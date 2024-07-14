#!/bin/bash

set -eu

source .env

if [ -f "cookies.txt" ]; then
	./scripts/start_session.sh
else
	expiry_date=$(grep "overleaf.sid" "cookies.txt" | awk '{print $5}')
	if [ -z "$expiry_date" ]; then
		./scripts/start_session.sh
	else
		if [ expiry_date -l $(date +%s) ]; then
			./scripts/start_session.sh
		fi
	fi
fi
