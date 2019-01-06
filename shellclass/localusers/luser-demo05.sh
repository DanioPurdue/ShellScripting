#!/bin/bash
# echo ${RANDOM}
PASSWORD="${RANDOM}"
echo "$PASSWORD"

# three random numbers together
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"

# Use the current date/time as the basis for the password
PASSWORD=$(date +%s)
echo "PASSWORD"
PASSWORD=$(date +%s%N)
echo "PASSWORD"

# A better password
PASSWORD=$(date +%s%N | sha256sum | head -c8)
echo "$PASSWORD"
SPECIAL_CHARS=$(echo 'dfasdfas' | fold -w1 | shuf | head -c1 )

