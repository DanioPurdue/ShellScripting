#!/bin/bash
if [[ "${UID}" -ne 0 ]]
then
    echo "Not the root user"
    exit 1
fi

if [[ "${#}" -lt 3 ]]
then
    echo "Not enough number of argument. Only ${#} of arguments has been provided" >&2
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
    echo "The user account cannot be created" >&2
    exit 1
fi
# Generate the password
PASSWORD="$(date +%s%N | sha256sum | head -c48)"
echo "Password: ${PASSWORD}"
echo "${PASSWORD}" | passwd --stdin ${USERNAME} &> /dev/null
if [[ "${?}" -ne 0 ]]
then
    echo "Passord failed to create" >&2
    userdel ${USERNAME}
    exit 1
fi
echo "Account and password has been successfully setted up" >&2
# Force user to change its password
passwd -e "${USERNAME}" &> /dev/null
exit 0