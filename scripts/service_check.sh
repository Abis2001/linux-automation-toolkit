#!/bin/bash

echo "SERVICE IS RUNNING OR NOT"

SERVICES=("ssh" "cron" "jenkins")

for SERVICE in "${SERVICES[@]}"
do
   STATUS=$(systemctl is-active "$SERVICE")
   if [ "$STATUS" =  "active" ]
   then
       echo "$SERVICE SERVICE IS RUNNING"
   else
       echo "WARNING: $SERVICE SERVICE IS NOT RUNNING"
   fi
done
