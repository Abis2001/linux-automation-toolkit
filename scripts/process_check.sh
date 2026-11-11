#!/bin/bash
echo "***********************"

echo "	  PROCESS CHECKING	"

echo "***********************"

echo "TOP 10 CONSUMING CPU PROCESS"

ps aux --sort=-%cpu | head -n 10

echo "TOP 10 CONSUMING MEMORY PROCESS"

ps aux --sort=-%mem | head -n 10

echo "JENKINS PROCESS STATUS"

if pgrep -f 'jenkins.war' > /dev/null 
then
    echo "Jenkins process is running"
else
    echo "WARNING: Jenkins process is not running"
fi
