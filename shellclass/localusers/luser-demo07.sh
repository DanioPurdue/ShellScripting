#!/bin/bash

# Demonstrate the use of while loop and shift
# Display the first three parameters
echo "Paramter 1: ${1}"
echo "Paramter 2: ${2}"
echo "Parameter 3: ${3}"

# Loop through all the positional parameters
while [[ "${#}" -gt 0 ]]
do 
    echo "Num of params: ${#}"
    echo "param1 : ${1}"
    echo "Param2 : ${2}"
    echo "param3 : ${3}"
    echo 
    shift #shift
done