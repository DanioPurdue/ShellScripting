# Network Programs

```shell
sudo echo test >> /etc/hosts #this will cause a permission denied because only echo got the users' right, the redirection does not have the redirection right.

ping -c1 server01 #test whether the server has been setted up or not
```

## How to ssh to another server

```shell
ssh-keygen
ssh-copy-id server01
# you can also generate the
ssh server01 hostname #you can run the command and exit
```

```shell
for SERVER in $(cat servers)
	ssh ${SERVER} hostname
	ssh ${SERVER} uptime
done
```

```shell
ssh server01 hostname ; hostname # the other one will be run on the local host

ssh server01 'hostname ; hostname' # both the two commands will occur at the remote host

# To put command into varaibles you could do the following
ssh server01 "${CMD1} ; ${CMD2}"
ssh server01 'ps -ef | head -3'
```

ssh exit status will be the exit status of the remote command, and unless the error is 255.

```shell
#!/bin/bash
SERVER_FILE='/vagrant/servers'
# make sure the server file exists
if [[ ! -e ${SERVER_FILE} ]]
then
	echo "Cannot open ${SERVER_FILE}." >&2
	exit 1
do

for SERVER in $(cat ${SERVER_FILE})
do
	echo "Pinging ${SERVER}"
	ping -c 1 ${SERVER} &> /dev/null
	if [[ "${?}" -ne 0 ]]
	then
		echo "${SERVER} down"
	else
		echo "${SSERVER} UP"
	fi
done

ssh server01 sudo id # you ssh to the server and th
sudo ssh server01 id # this makes you root first, and then connected to the server 01 
```

