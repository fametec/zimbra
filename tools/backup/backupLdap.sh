#!/bin/bash

# set -xv

NOW=`date +%Y_%m_%d_%H_%M`

BACKUP_DIR=/opt/zimbra/backup/ldap
NFS_DIR=/backup-zimbra/ldap

if [ -d $BACKUP_DIR ]
then
        mkdir -p $BACKUP_DIR
        chown zimbra:zimbra $BACKUP_DIR
fi


if [ -d $NFS_DIR/$NOW ]
then
        mkdir -p $NFS_DIR/$NOW/
fi


echo -n "Backup OpenLDAP to $NFS_DIR/$NOW ... "


su - zimbra -c "/opt/zimbra/libexec/zmslapcat $BACKUP_DIR"
su - zimbra -c "/opt/zimbra/libexec/zmslapcat -c $BACKUP_DIR"
su - zimbra -c "/opt/zimbra/libexec/zmslapcat -a $BACKUP_DIR"

mv $BACKUP_DIR $NFS_DIR/$NOW/

echo "done"
