#!/bin/bash

echo "************************************"
echo "       DISK USAGE CHECK"
echo "************************************"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')

echo "DISK USAGE = $DISK_USAGE%"

if [ "$DISK_USAGE" -gt 80 ]
then
    echo "WARNING: DISK USAGE IS HIGH"
else
    echo "DISK USAGE IS NORMAL"
fi 
