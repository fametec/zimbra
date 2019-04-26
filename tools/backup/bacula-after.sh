#!/bin/bash

echo -n "apagando /opt/zimbra/backup/mysql ..."

rm -rf /opt/zimbra/backup/mysql/*

if [ $? -eq 0 ] 
then
  echo " [   OK    ]"
else
  echo " [   FAIL   ]"
  exit 1
fi


echo -n "apagando /opt/zimbra/backup/ldap ..."

rm -rf /opt/zimbra/backup/ldap/*

if [ $? -eq 0 ]
then
  echo " [   OK    ]"
else
  echo " [   FAIL   ]"
  exit 1
fi
