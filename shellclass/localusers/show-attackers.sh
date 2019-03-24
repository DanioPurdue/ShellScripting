#!/bin/bash
if [[ ! -e "${1}" ]]
then
    echo "file not found">&2
    exit 1
fi
echo "Count,IP,Location"
grep 'Failed password' ${1} | awk '{print geoiplookup $(NF-3)}' | sort -n | uniq -c | awk '{if ($1 > 10) print $1, $2}' | sort -nr | while read COUNT IP
do
    echo "${COUNT},${IP},$(geoiplookup ${IP} | awk -F ', ' '{print $(NF)}')"
done