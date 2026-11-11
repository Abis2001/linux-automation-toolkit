#!/bin/bash
echo "***********************************"

echo " MEMORY USAGE CHECK "

echo "**********************************"

MEMORY_USAGE=$(free | awk '/^Mem:/ {printf "%.0f" ,($2-$7)/$2*100}')

echo "MEMORY USAGE: $MEMORY_USAGE%"

if [ "$MEMORY_USAGE" -gt 80 ]
then
    echo "WARNING MEMORY IS HIGH"
else
    echo "MEMORY IS NORMAL"
fi



echo "********************************"
