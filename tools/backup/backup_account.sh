#!/bin/bash
# set -xv
# Script para backup


if [ -z $1 ]
then
    echo "First param not found..."
    echo "Use: $0 account backup_file.tgz"
    exit 1
 fi

if [ -z $2 ]
then
    echo "Second params not found..."
    echo "Use: $0 account backup_file.tgz"
    exit 1
fi


if [ "$USER" != "zimbra" ]
then
    echo "Is not zimbra user"
    echo "use: su - zimbra"
    exit 2
fi

echo -n "Backup of $1 ..."

/opt/zimbra/bin/zmmailbox -z -m $1 getRestURL "//?fmt=tgz" > $2.tgz

if [ $? -eq 0 ]; then

    echo "done"

else

    echo "fail"

    exit 1

fi

