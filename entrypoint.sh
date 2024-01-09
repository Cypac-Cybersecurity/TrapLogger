#!/bin/bash

# Check if the opencanary.conf file exists
CONF_FILE="/opencanary/opencanary.conf"
if [ ! -f "$CONF_FILE" ]; then
    echo "Error: Configuration file not found: $CONF_FILE"
    exit 1
fi

# Substitute environment variables in the opencanary.conf file
envsubst < "$CONF_FILE" > "${CONF_FILE}.tmp"
mv "${CONF_FILE}.tmp" "$CONF_FILE"

# Ensure permissions are correct
chmod 644 "$CONF_FILE"

# Start OpenCanary
exec opencanaryd "$@"
