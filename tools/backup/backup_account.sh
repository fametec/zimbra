#!/bin/bash
# set -xv
# Script para backup


    if [ -z $1 ]; then
      
      echo "Use: $0 account"; 

      exit 1

    fi
  
      echo -n "Backup of $1 ..."

      /opt/zimbra/bin/zmmailbox -z -m $1 getRestURL "//?fmt=tgz" > /opt/zimbra/backup/contas/$1.tgz

      if [ $? -eq 0 ]; then

        echo " OK "

        exit 0

      else 

        echo " FAIL "
       
        exit 1

      fi



