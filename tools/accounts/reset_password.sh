#!/bin/bash

# set -x

# ACCOUNTS="eduardo@eftech.com.br"

if [ -z $1 ]
then
  echo "Use: $0 account"
  exit 1
fi

ACCOUNTS=$1

randomPassword(){

	echo `date +%s | sha256sum | base64 | head -c 8`

}


forceChangePassword(){

        if [ -z $1 ]; then

 		echo "Use: $0 account"
                exit 1

	fi

	 su - zimbra -c "zmprov -l modifyAccount $1 zimbraPasswordMustChange TRUE"

}

setPassword() {

	if [ -z $1 ] || [ -z $2 ]
	then

		echo "Use: $0 account password"
		exit 2

	fi

	su - zimbra -c "zmprov -l sp $1 $2"

}


for i in $ACCOUNTS
do

	pass=`randomPassword`

	setPassword $i "$pass"

	forceChangePassword $i

	echo "$i:$pass" >> /opt/zimbra/backup/passwords.txt


done
