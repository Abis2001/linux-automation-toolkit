#!/bin/bash
SOURCE="$HOME/linux-automation-toolkit/log"


for FILE in "$SOURCE"/*.log
do
	if [ -f "$FILE" ]
	then
		if [ -f "$FILE".gz ]
		then
			echo "Already compressed file is $FILE"
		else
			gzip -k "$FILE"
			
			if [ $? -eq 0 ]
			then
				echo "SUCESS $FILE COMPRESSED "
			else
				echo "ERROR: Compression failed for $FILE"
			fi		
		fi
	fi
done


