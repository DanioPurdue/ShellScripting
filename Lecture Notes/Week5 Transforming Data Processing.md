## cut

remove sections from each line of files

this is kind of like a substring

```shell
cut -c 1 /etc/passwd #show the first character of each line
cut -c 7 /etc/passwd #show the 7th character of each line
cut -c 4-7 /etc/passwd #show fourth to seventh character of each line
cut -c 4- /etc/passwd #starting from the fourth
cut -c -4 #which is equivalent of 1-4
cut -c 3,4,5 /etc/passwd
```

```shell
cut -b # split by bytes
```

```shell
echo -e "hello\tworld" #this would interpretate a back space
echo -e 'one\ttwo\tthress' | cut -f 2 #this is used to select the second column
echo -e 'one,two,three' | cut -d ',' -f 2
```

```shell
cut -d ',' -f 1 people.csv
```

```shell
grep '^first' people.csv #matches all the lines start with the "first"
grep 't$' people.csv # matches with the tail
grep '^first, last$' people.csv #this enforces hte exact match
grep -v <- this is a inverse matching
```

cut only handle only single character deliminator. If you want to use more complex deliminator, you should use awk.

## awk

```shell
awk -F 'DATA:' '{print $2}' people.dat
awk -F ':' '{print $2, $3}' people.dat #the default space seperator to is space
# to change the ofs
awk -F ':' -v OFS=',' '{print $2, $3}' people.dat
```

the order of the output changes.

```shell
awk -F ':' '{print $(NF - 1)}' /etc/passwd # the second last parameter of the output.
```

## Open Network Ports

```shell
netstat -nutl
# -n show the port number
# -u udp
# -t tcp
# -l listening port
# -p would show the process id
```

you can use to get rid of the header

```shell
grep -Ev '^Active|^Photo' #this is a regular expression
```

## `sort`

```shell
sort -n
sort -nr # reverse the order
sort -h # works with human readable number so that it cam sort human readable things
sort -u # does not sort, it just keep unique 
```



## `uniq`

this unique only works with the sorted output

```shell
sort -n | uniq
sort -n | uniq -c #this also gives the count of each unique occurence
```

```shell
wc -l /etc/passwd # just the line count
wc -w /etc/passwd # word count

grep bash /etc/passwd | wc -l #this is used to count the number of users use bash commands
grep -c bash /etc/passwd #this also does the acount

cat /etc/passwd | sort -t ':' -k 3 -n
# -t can be used to customly define key
# -k is used to select the field
# -n is used to select the third field
```

get top three most visited example

```shell
LOG_FILE="${1}"
if [[ ! -e "${LOG_FILE}" ]]
then
	echo "Cannot open ${LOG_FILE}" >&2
	exit 1
fi
cut -d '"' -f 2 ${LOG_FILE} | cut -d ' ' -f 2 | sort | uniq -c | sort -n | tail -3
```

