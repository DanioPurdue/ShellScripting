#!/bin/bash
# this files allow user to run commands from the remote machine
usage() {
    echo "run-everywhere.sh [-fnsv] command"
    exit 1
}

# check user access
if [[ ${UID} = 0 ]]
then
    echo "No Superuser priviledges" >&2
    usage
fi

SUPERUSER=''
FILEDIREC='/vagrant/servers'
while getopts f:nsv OPTION
do
    case ${OPTION} in
        v)
            VERBOSE='true'
            echo 'Verbose is turned on flag'
            ;;
        f)
            OWNFILE='true'
            FILEDIREC="${OPTARG}"
            echo "Use your own file flag: ${OPTARG}"
            ;;
        n)
            DRYRUN='true'
            echo "Dry run flag"
            ;;
        s)
            SUPERUSER=' sudo'
            echo 'Super user'
            ;;
        *)
            usage
        esac
done
# check whether an input command has been provided
shift "$((OPTIND - 1))"
if [[ "${#}" = 0 ]]
then
    usage
fi

#check server directory
if [[ ! -e ${FILEDIREC} ]]
then
    echo "${FILEDIREC} does not exist" >&2
    usage
fi
COMMAND="${@}"
SSH_OPTION='-o ConnectTimeout=2'
#dry run check
if [[ ${DRYRUN} = 'true' ]]
then
    echo 'Dry running the commands'
    for SERVERNAME in $(cat ${FILEDIREC})
    do
        echo "ssh ${SSH_OPTION} ${SERVERNAME}${SUPERUSER} '${COMMAND}'"
    done
    exit 0
fi

#Execute the commands
for SERVERNAME in $(cat ${FILEDIREC})
do
    ssh ${SSH_OPTION} ${SERVERNAME}${SUPERUSER} "${COMMAND}"
done