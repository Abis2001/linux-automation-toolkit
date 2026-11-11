#!/bin/bash

read -p "Enter the username to create " USERNAME

if [[ ! "$USERNAME" =~ ^[a-z_][a-z0-9_-]*[@]?$ ]]
then
	echo "ERROR: Invalid username"
	exit 1
fi

if id  "$USERNAME" &> /dev/null
then
	echo "User $USERNAME already exists"
else
	sudo useradd -m "$USERNAME"

	if [ $? -eq 0 ]
	then
		echo "User $USERNAME created successfully"
	else
		echo "ERROR: User creation failed"
       		exit 1
    	fi

fi
