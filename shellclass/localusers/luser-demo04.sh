#!/bin/bash

# this creates account on the local system
read -p 'Enter the username to create: ' USER_NAME
# you will be promted for the account name and password
read -p 'Enter the name of hte person who this account is for: ' COMMENT
read -p 'Enter the password to use for the account: ' PASSWORD
useradd -c "${COMMENT}" -m ${USER_NAME}

# ask fo the user
# ask for the real name
# ask for the password
# set the passowrd for the user
# force the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
# force password change on the first login
passwd -e ${USER_NAME}