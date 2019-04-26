#!/bin/bash
#
#===============================================================================
#
#          FILE:  backup_and_delete.sh
# 
#         USAGE:  ./backup_and_delete.sh 
# 
#   DESCRIPTION:  Make a backup and remove account listed in 
#                 accounts_to_backup_and_remove.txt file except the account
#                 listed in accounts_as_exception.txt
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  accounts_to_backup_and_remove.txt file
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Eduardo Fraga <eduardo@fametec.com.br>
#       COMPANY:  FAMETEC
#       VERSION:  1.0
#       CREATED:  April 26 2019
#      REVISION:  ---
#===============================================================================
#
#===============================================================================
##Debug
# set -xv
#
#===============================================================================

checkAccountException () {

  if [ -z $1 ]; then 

    exit 100

  fi

  if [ -e accounts_as_exception.txt ] ; then

    local VERIFY=`grep -c $1 accounts_as_exception.txt`

  fi

  return $VERIFY

} 

checkFileAccounts () {

  if [ -e accounts_to_backup_and_remove.txt ]; then

    echo "Account file found..."

  else

    echo "Error: File accounts_to_backup_and_remove.txt not found"

    exit 101

  fi

}

backupAccounts () {

    if [ -z $1 ]; then
      
      echo "Use $0: account"; 

      exit 1

    fi
  
    checkAccountException $1

    if [ $?  == "0" ]; then 

      echo -n "Backup of $1 ..."

      /opt/zimbra/bin/zmmailbox -z -m $1 getRestURL "//?fmt=tgz" > /opt/zimbra/backup/contas/$1.tgz

      if [ $? -eq 0 ]; then

        echo " OK "

        return 0

      else 

        echo " FAIL "
       
        return 1

      fi

    fi

}



removeAccounts () { 

   if [ -z $1 ]; then

      echo "Use $0: account";

      exit 1

   fi
   
   checkAccountException $1

   if [ $? == "0" ]; then

      echo -n "Removing account $1 ... "
      
      /opt/zimbra/bin/zmprov da $1 

      if [ $? -eq 0 ]; then
        
        echo " OK" 

        return 0

      else

        echo " FAIL "
        
        return 1
 
      fi
      
   fi   

}


checkFileAccounts 

for LIST in `cat accounts_to_backup_and_remove.txt`; do 

  backupAccounts $LIST

  if [ $? == "0" ]; then

    removeAccounts $LIST

  fi

done
