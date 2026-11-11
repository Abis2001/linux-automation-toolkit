#!/bin/bash
SOURCE="$HOME/backup-test"
DEST="$HOME/linux-automation-toolkit/backups"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$DEST/backup_$TIMESTAMP.tar.gz"


if [ -d "$SOURCE" ]
then
	mkdir -p "$DEST"

	tar -czf  "$BACKUP_FILE" -C "$HOME" backup-test

	if [ $? -eq 0 ]
	then
		  echo "BACKUP SUCCESSFUL"
       		  echo "Backup file: $BACKUP_FILE"
	else
		echo "ERROR: BACKUP FAILED"
       	 	exit 1
	fi
else
	 echo "ERROR: SOURCE DIRECTORY NOT FOUND"
    	exit 1
fi
