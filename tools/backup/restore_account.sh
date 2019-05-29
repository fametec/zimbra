#!/bin/bash

#set -xv

if [ -z $1 ]
then
    echo "Params not found..."
    echo "Use: $0 account backup_file.tgz"
    exit 1
 fi

if [ -z $2 ]
then
    echo "Params not found..."
    echo "Use: $0 account backup_file.tgz"
    exit 1
fi


if [ "$USER" != "zimbra" ]
then
    echo "Is not zimbra user"
    echo "use: su - zimbra"
    exit 2
fi


echo -n "Restoring ${1}..."

#/opt/zimbra/bin/zmmailbox -z -m "$1" pru '//?fmt=tgz&resolve=reset' "$2"
/opt/zimbra/bin/zmmailbox -z -m "$1" pru '//?fmt=tgz&resolve=modify' "$2"

if [ $? -eq 0 ]
then

    echo "done"

else

    echo "fail"
    exit 3
fi




