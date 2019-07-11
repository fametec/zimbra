#!/bin/bash
# set -xv
# Script para backup


if [ -z $1 ]
then

    echo "Use: $0 account or $0 account path_destination";

    exit 2

fi


if [ -z $2 ]
then

    DESTINATION=/opt/zimbra/backup/accounts

else

    DESTINATION=$2

fi


if [ ! -d $DESTINATION ]
then

    mkdir -p $DESTINATION

fi


echo -n "Backup of $1 to ${DESTINATION}/${1}.tgz ..."

su - zimbra -c "/opt/zimbra/bin/zmmailbox -t 0 -z -m ${1} getRestURL \"//?fmt=tgz\" > ${DESTINATION}/${1}.tgz"

if [ $? -eq 0 ]
then

    echo " done "

    exit 0

else

    echo " fail "

    exit 1

fi
