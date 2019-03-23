#!/bin/bash
usage() {
    echo "Usage ${0} [-dra] usernames" >&2
    echo "-d Deletes accounts instead of disabling them" >&2
    echo "-r Removes the home directory associated with the account" >&2
    echo "-a Creates an archive of hte home directory assocaited with the accounts and stores the archive" >&2
    exit 1
}

log() {
    echo "Message: ${@}">&2
}
# Check root user access
if [[ "${UID}" -ne 0 ]]
then
    echo "Not root user!" >&2
    exit 1
fi

deleteAccount() {
    log "Trying to delete the account"
    local USERNAME
    USERNAME="${@}"
    userdel "${USERNAME}"
    if [[ ${?} -ne 0 ]]
    then
        log "Failed to delete the account"
        exit 1
    fi
}

archiveAccount() {
    log "trying to archive the account"
    local USERNAME
    USERNAME="${@}"
    echo "username: ${USERNAME}"
    createArchiveIfNotExist
    tar -cf "/home/archive/${USERNAME}.tar" -C "/" "home/${USERNAME}"
    if [[ ${?} -ne 0 ]]
    then
        log "Fail to archive the account"
    fi
}

createArchiveIfNotExist() {
    local DIREC
    DIREC=$(find /home/ -maxdepth 1 -name "archive" -type d)
    if [[ ${DIREC} = "" ]]
    then
        log "Creating the archive director"
        mkdir /home/archive
        if [[ ${?} -ne 0 ]]
        then
            log "Fails to create an archive home directory"
            exit 1
        fi
    fi
}

removeHomeDir() {
    log "tring to remove the home directory of the account"
    local DIREC
    DIREC="/home/${@}"
    rm -rf "${DIREC}"
    if [[ ${?} -ne 0 ]]
        then
            log "Fails to remove home directory"
            exit 1
    fi
}

# Check the flags
while getopts dra OPTION
do
    case ${OPTION} in 
    d)
        DELETES='true'
        log "Delete accounts"
        ;;
    r)
        REMOVES='true'
        log "Remove account options"
        ;;
    a)
        ARCHIVES='true'
        log "Archive accounts"
        ;;
    *)
        usage
        ;;
    esac
done

# Check user names
echo "next argument to be processed: ${OPTIND}"

# shift index
shift "$((OPTIND - 1))"
if [[ "${#}" = 0 ]]
then
    log "Please provide username"
    usage
fi

# iterate through the user name
for USERNAME in "${@}"
do
    echo "username: ${USERNAME}"
    M_UID=$(id -u ${USERNAME})
    echo "USER ID: ${M_UID}"
    if [[ "${M_UID}" -lt 1000 ]]
    then
        log "user id is less than 1000"
        continue
    fi
    # Archive account
    if [[ "${ARCHIVES}" = 'true' ]]
    then
        archiveAccount "${USERNAME}"
    fi
    # remove the home directory
    if [[ "${REMOVES}" = 'true' ]]
    then
        removeHomeDir "${USERNAME}"
    fi
    # delete the account
    if [[ "${DELTES}" = 'true' ]]
    then
        deleteAccount "${USERNAME}"
    else
        sudo chage -E 0 "${USERNAME}"
    fi
done

exit 0
