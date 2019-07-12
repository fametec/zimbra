#!/bin/bash
# set -xv
# Script for backup daily


if [ -z $1 ]
then

    echo "Use: $0 account or $0 account path_destination";

    exit 2

fi


if [ -z $2 ]
then

    DESTINATION=/opt/zimbra/backup/accounts/$1

else

    DESTINATION=$2/$1

fi

if [ -z $1 ]
then

    echo "Use: $0 account";

    exit 2

fi

if [ ! -d $DESTINATION ]
then

    mkdir -p $DESTINATION

    chown zimbra:zimbra $DESTINATION

fi

STARTTIME=$(date -d '-1 day' +%Y/%m/%d)

STARTTIME1=$(date -d '-1 day' +%Y-%m-%d)

ENDTIME=$(date -d '+1 day' +%Y/%m/%d)

echo -n "Backup of $1 to ${DESTINATION}/${1}-${STARTTIME1}.tgz ..."

su - zimbra -c "/opt/zimbra/bin/zmmailbox -t 0 -z -m ${1} getRestURL --startTime $STARTTIME --endTime $ENDTIME \"//?fmt=tgz\" > ${DESTINATION}/${1}-${STARTTIME1}.tgz"

if [ $? -eq 0 ]
then

    echo " done "

    exit 0

else

    echo " fail "

    exit 1

fi
