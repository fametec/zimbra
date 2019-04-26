#!/bin/bash
#set -x

sudo su - zimbra -c '/usr/local/bin/bkp_ldap.sh'

if [ $? -eq 0 ]
then
  echo " Backup LDAP concluido... "
else
  echo " Backup LDAP falhou... "
  exit 1
fi

sudo su - zimbra -c '/usr/local/bin/bkp_mysql.sh'

if [ $? -eq 0 ]
then
  echo " Backup MySQL concluido... "
else
  echo " Backup MySQL falhou... "
  exit 1
fi

