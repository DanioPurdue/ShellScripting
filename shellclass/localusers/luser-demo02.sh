#!/bin/bash

#Display the UID and username of the user executing this script
#diplay if the user is the root user of not

# Display UID
echo "Your UID is ${UID}"

# Display the username
# Display the user is the root or not
# USER_NAME=$(id -un)
USER_NAME=`id -un`
echo "Your user name is $USER_NAME"

# Display if statement
if [[ "${UID}" -eq 0 ]]
then
    echo 'you are root'
else
    echo 'You are not root'
fi