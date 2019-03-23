## Case Statement

```shell
#!/bin/bash
# The script demonstrates the case statement
if [["${1}" = "start"]]
then
	echo "Starting"
	exit 1
elif [["${1}" = 'stop']]
then
	echo 'Status:'
fi

# Case statement
case "${1}" in 
	start)
		echo 'Starting.'
		;;
	stop)
		echo 'Stopping: '
		;;
	status|state) # you can have the or statement here, which looks like a pipe
		echo 'Status:'
		;;
	*)
		echo 'Supply a valid option. ' >&2
		;;
esac	
```

## Functions

DRY: Don't Repeat Yourself

Define the function before you use it

${0} is the name of the script but the input is taken

```shell
log() {
    echo 'You called the log function'
}

log() {
	# So far we have been using global function, now we should use local function
    local MESSAGE="${@}" #Only exists inside a function
    echo "${MESSAGE}"
}
function log {
    echo 'You call the log function'
}
log 'Hello!'
VERBOSE='true'
log 'This is fun'
```

Approach without using the global variable

```shell
log() {
    local VERBOSE="${1}"
    shift
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
    	echo "${MESSAGE}"
    fi
}

readonly VERBOSE='true' # use readonly to seperate the variable name

```

```shell
backup_file() {
    # This function creates a backup of a file. Returns non-zero status on error
    local FILE="${1}"
    if [[ -f "${FILE}" ]]
    then
    	local BACKUP_FILE = "/var/temp/$(basename ${FILE}).$(date +%F-%N)"
    	log "Backing up ${FILE} to ${BACKUP_FILE}"
    	cp -p ${FILE} ${BACKUP_FILE}
    else
    	# the file does not exist, so return a non-zero exit status
    	return 1
    fi
}

# Make a decision based on hte exit status of the function
if [[ "${?}" -eq '0' ]]
then
	log 'File backup succeeded'
else
	log 'File backup failed'
	exit 1
fi
```

## GetOpts

use shell built-in commnad is easier.

```shell
#!/bin/bash

# this script generates a random passord
# this user can set the password length with -l and add a special character with -s.
# verbose mode can be enabled with -v

usage() {
    echo "Usage: ${0} [-vs][-l LENGTH]" >&2
    echo 'Generate a random password'
    echo ' -l LENGTH specify the password length'
    echo ' -s Append a special character to the password'
    echo ' -v Increase verbosit'
    exit 1
}

log() {
	local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then 
        echo $MESSAGE
    fi
}

# set a default password
LENGTH=48

while getopts vl:s OPTION # colomn means that -l must be followed with an argument of its own
do
	case ${OPTION} in
		v)
		 VERBOSE='true'
		 log 'Verbose mode is on'
		 ;;
		 l)
		 LENGTH="${OPTARG}"
		 ;;
		 s)
		 USE_SPECIAL_CHARACTER='true'
		 ?) # for the case yo dont 
		 usage
		 exit 1
		 ;;
	esac
done

echo "Number of args: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

#Insepect OPTIN
echo "OPTIN: ${OPTIND}"
shift "$((OPTIND - 1))"

if [["${#}" -gt 0]]
then
	usage
fi

log "Generating a passowrd"
PASSWORD=$(date +%s%N${RANDOM}${RANOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so
if [[ "${USER_SPECICAL_CHARACTER}" = 'true' ]]
then
	log 'Selecting a random special character.'
	SPECIAL_CHARACTER=$(echo '!@#$' | fold -w1 | shuf | head -c1) # what are the fold and the shuffle command.
	PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi
log 'Done'
log 'Here is the passord'
echo "${PASSWORD}"
exit 0 
```



If a function is not found, you should look for it by using

```shell
sudo find / -name userdel
```

sometimes you need a root permission to access the file.

## `tar` command

```shell
tar -cf catvideos.tar catvideos #catvideos is the folder that will be compressed
# you can also do -cvf to print the files that will be compressed.
```

```shell
tar -xf ../catvideos.tar #now we extract the files
```

create a tar file

```shell
tar -cvf catvideos.tar catvideos/

# Compress
gzip catvideos.tar
# Uncompress
gunzip catvideos.tar.gz
```

## Lock the accound

suppose you have a user called woz.

```shell
# lock the account by changing the expiration date
sudo chage -E 0 woz
# unlock the account
sudo chage -E -1 woz

# lock the password
sudo passwd -l woz
# unlock the password
sudo passwd -u woz

# set the login of the user to no login
sudo usermod -s /sbin/nologin woz
```

```shell
#!/bin/bash
#This script deletes a user
```

