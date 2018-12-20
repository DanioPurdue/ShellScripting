#!/bin/bash

# Display the UID and the user executing this script
echo "Your UID is ${UID}"
UID_TO_TEST_FOR='1000'
# Display the UID
# only display if the UID does not match 1000
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
    echo "Your UID does not match ${UID_TO_TEST_FOR}"
    exit 1
fi

USER_NAME=$(id -un)
# test if the command succedded
if [[ "${?}" -ne 0 ]]
then
    echo 'The id command did not execute successfully'
    exit 1
fi
echo "you user name is succeeded"
# you can use a string test conditionl
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your name matches"
fi
# test for !=(not equal) for the string
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your user name does not equal "
    exit 1
fi
exit 0