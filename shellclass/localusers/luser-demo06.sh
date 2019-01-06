#!/bin/bash

# This script generates a random password for each user specified on the command line

# Display waht the user typed on the command line
echo "You executed this command ${0}" # this is a special vairable

# Diplay the path and the filename of the script
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script"

# How many arguments they passed in
# Inside teh script they are parameters, outside they are arguments
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

# Make sure they supply at least one arguement

if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [USERNAME]..."
    exit 1
fi

# Generate and display a password for each parameter
for USERNAME in "${@}"
do
    PASSWORD=$(date +%s%N | sha256sum | head -c48)
    echo "${USERNAME}: ${PASSWORD}"
done
