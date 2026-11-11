#!/bin/bash

PROJECT="$HOME/linux-automation-toolkit"
SCRIPTS="$PROJECT/scripts"

echo "======================================"
echo "       LINUX SERVER MONITORING"
echo "======================================"

for SCRIPT in cpu_check memory_check disk_check process_check service_check uptime
do
    echo ""
    echo "Running $SCRIPT.sh"
    echo "--------------------------------------"

    bash "$SCRIPTS/$SCRIPT.sh"

    if [ $? -ne 0 ]
    then
        echo "WARNING: $SCRIPT.sh failed"
    fi
done

echo ""
echo "======================================"
echo "       MONITORING COMPLETED"
echo "======================================"
