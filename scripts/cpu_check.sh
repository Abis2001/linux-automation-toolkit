#!/bin/bash
echo "***************************************"

echo "		CPU MONITORING USAGE         "

echo "***************************************"


CPU_IDLE=$(top -bn1 | grep "%Cpu" | awk -F',' '{print $4}' | awk '{print $1}')

CPU_USAGE=$(awk -v idle="$CPU_IDLE" 'BEGIN {printf "%.0f", 100-idle}')

echo Cpu_Usage="$CPU_USAGE%"

if [ "$CPU_USAGE" -gt 80 ]
then
    echo "WARNING : CPU USAGE IS HIGH"
else
    echo "CPU USAGE IS NORMAL"
fi
