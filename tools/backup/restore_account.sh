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


echo -n "Restoring ${1} from ${2} ..."

/opt/zimbra/bin/zmmailbox -t 0 -z -m "$1" pru -u https://`zmhostname` '//?fmt=tgz&resolve=skip' "$2"

# The resolve= parameter has several options:
# - skip:    ignores duplicates of old items, it’s also the default conflict-resolution.
# - modify:  changes old items.
# - reset:   will delete the old subfolder (or entire mailbox if /).
# - replace: will delete and re-enter them.


if [ $? -eq 0 ]
then

    echo "done!"

else

    echo "fail!"
    exit 3
    
fi




