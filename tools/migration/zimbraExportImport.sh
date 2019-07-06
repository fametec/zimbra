#!/bin/bash
# 
set -x
# Requirements: ssh-keygen and ssh-copy-id

ZIMBRASOURCE=10.0.0.30
TEMPDIR=/opt/tempdir

ACCOUNTS=`ssh $ZIMBRASOURCE 'su - zimbra -c "zmprov -l gaa"'`


if [ ! -d $TEMPDIR ]; then 

  mkdir -p $TEMPDIR

fi


testSshConnect() {

  echo -n 'Test ssh...'

  ssh $ZIMBRASOURCE 'exit'

  if [ $? -ne 0 ]; then
    echo "fail"
    exit 1
  fi

  echo "done"

}


remoteBackupAccount() {

    if [ -z $1 ] ; then
       echo "Use: $0 account"
       return 1
    fi

    echo -n "backup $1 ..."

    ssh $ZIMBRASOURCE "su - zimbra -c '/opt/zimbra/bin/backup_account.sh '$i''"

    if [ $? -ne 0 ]; then
       echo "fail"
       return 2
    fi

    echo "done"

}


copyFromRemote() {

    if [ -z $1 ] ; then
       echo "Use: $0 account" 
       return 1
    fi

    echo -n "remote copy $1 ..."
    
    scp $ZIMBRASOURCE:/opt/zimbra/backup/contas/${1}.tgz $TEMPDIR/
    
    if [ $? -ne 0 ]; then
      echo "fail"
      return 2
    fi

    ssh $ZIMBRASOURCE "rm -rf /opt/zimbra/backup/contas/${1}.tgz"

    chown -R zimbra:zimbra $TEMPDIR/${1}.tgz


     echo "done"

}


restoreAccount() {
    
    if [ -z $1 ] ; then
       echo "Use: $0 account"
       return 1
    fi

    echo "Restore account $1 ..."

    su - zimbra -c "/opt/zimbra/bin/zmmailbox -t 0 -z -m ${1} pru -u https://`zmhostname` \"//?fmt=tgz&resolve=skip\" ${TEMPDIR}/${1}.tgz"

# su - zimbra -c "/opt/zimbra/bin/zmmailbox -t 0 -z -m ${1} pru -u https://`zmhostname` \"//?fmt=tgz&resolve=skip\" ${TEMPDIR}/${1}.tgz"



    if [ $? -ne 0 ]; then
      echo "$1 failed" >> /tmp/restore.log
      return 2
    else 
      echo "$1 successfully " >> /tmp/restore.log
    fi

    echo "done"

}


removeBackupFile() {
   
   if [ -z $1 ] ; then
      echo "Use: $0 account"
      return 1
   fi

   echo -n "Clean tempdir..."

   rm -rf ${TEMPDIR}/${1}.tgz

   if [ $? -ne 0 ]; then
      return 2
   fi

   echo "done"

}


for i in $ACCOUNTS; do
  
  testSshConnect
  remoteBackupAccount $i
  copyFromRemote $i
  restoreAccount $i
  removeBackupFile $i

done


