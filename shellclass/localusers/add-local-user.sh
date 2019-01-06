#!/bin/bash
if [[ ${UID} -ne 0 ]]
then
    echo "not the root user"
    exit 1
fi
echo "Root User"
read -p 'Enter the username: ' USER_NAME
read -p 'Enter the first name and the last name: ' COMMENT
read -p 'Type Password: ' PASSWORD

# create the account with password
useradd -c "${COMMENT}" -m $USER_NAME
if [[ "${?}" -ne 0 ]]
then 
    echo "account is failed to create"
    exit 1
fi
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then
    echo "Password is failed to set"
    exit 1
fi

# Print the result
echo "username: " 
echo "${USER_NAME}"
echo "full name:"
echo "${COMMENT}"