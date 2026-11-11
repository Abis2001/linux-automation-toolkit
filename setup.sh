#!/bin/bash

PROJECT_DIR="$HOME/linux-automation-toolkit"

echo "=================================="
echo " LINUX TOOLKIT SETUP"
echo "=================================="

# Create required directories
mkdir -p "$PROJECT_DIR/backups"
mkdir -p "$PROJECT_DIR/log"
mkdir -p "$PROJECT_DIR/cleanup-test"

# Set executable permissions
chmod +x "$PROJECT_DIR"/scripts/*.sh

echo "Project directories created."
echo "Script permissions updated."

# Check required commands
for COMMAND in bash awk df free ps tar gzip find
do
    if command -v "$COMMAND" > /dev/null 2>&1
    then
        echo "PASS: $COMMAND is available"
    else
        echo "WARNING: $COMMAND is not installed"
    fi
done

echo "=================================="
echo " SETUP COMPLETED"
echo "=================================="
