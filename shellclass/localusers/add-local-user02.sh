#!/bin/bash
if [[ "${UID}" -ne 0 ]]
then
    echo "Not the root user"
    exit 1
fi

if [[ "${#}" -lt 3 ]]
then
    echo "Not enough number of argument. Only ${#} of arguments has been provided"
    exit 1
fi
echo "Root User!"
USERNAME=${1}
FIRSTNAME=${2}
LASTNAME=${3}
echo "username: ${USERNAME}"
# Add User
useradd -c "${FIRSTNAME} ${LASTNAME}" -m "$USERNAME"
if [[ "${?}" -ne 0 ]]
then
    echo "The user account cannot be created"
    exit 1
fi
# Generate the password
PASSWORD="$(date +%s%N | sha256sum | head -c48)"
echo "Password: ${PASSWORD}"
passwd ${USERNAME} --stdin ${PASSWORD}
if [[ "${?}" -ne 0 ]]
then
    echo "Passord failed to create"
    userdel ${USERNAME}
    exit 1
fi
echo "Account and password has been successfully setted up"
exit 0