#!/bin/bash

# Path to the configuration template and final configuration
CONF_TEMPLATE="/opencanary/opencanary.conf.template"
CONF_FILE="/opencanary/opencanary.conf"

# Substitute placeholders with environment variable values
envsubst < "$CONF_TEMPLATE" > "$CONF_FILE"

# Ensure permissions are correct
chmod 644 "$CONF_FILE"

# Start OpenCanary
cat "$CONF_FILE"  # Add this line for debugging
exec opencanaryd "$@"
