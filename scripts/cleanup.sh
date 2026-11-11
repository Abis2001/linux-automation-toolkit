#!/bin/bash

TARGET="$HOME/linux-automation-toolkit/cleanup-test"

echo "***********************************"
echo "         CLEANUP TOOL"
echo "***********************************"

if [ -d "$TARGET" ]
then
    echo "Checking temporary files..."

    find "$TARGET" -maxdepth 1 -type f -name "*.tmp" -print

    find "$TARGET" -maxdepth 1 -type f -name "*.tmp" -delete

    echo "Temporary files cleaned successfully."
else
    echo "ERROR: TARGET DIRECTORY NOT FOUND"
    exit 1
fi

echo "***********************************"
