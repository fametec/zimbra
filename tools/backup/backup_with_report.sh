#!/bin/bash
#
## DEBUG
# set -x

# Require: backup_account.sh

BACKUP_DIR=/opt/zimbra/backup/accounts

OUTPUT=$BACKUP_DIR/backup_report.csv

if [ -z $1 ]; then
        ACCOUNTS="`su - zimbra -c "zmprov -l gaa" | sort`"
else
        ACCOUNTS=$1
fi


if [ -x backup_account.sh ]
then

  echo "Error: backup_account.sh not found. "

fi


echo '"start_date","account","mailbox_size","backup_size","end_date"' > $OUTPUT

for i in $ACCOUNTS

do

  MBOXSIZE=`su - zimbra -c "zmmailbox -z -m $i gms"`

  echo -n "\"`date +%Y-%m-%d\ %H:%M`\"," >> $OUTPUT

  echo -n "\"$i\"," >> $OUTPUT

  ./backup_account.sh $i "$BACKUP_DIR"

  echo -n "\"$MBOXSIZE\"," >> $OUTPUT

  echo -n "\"`ls -lh $BACKUP_DIR/${i}.tgz | cut -d ' ' -f 5` \"," >> $OUTPUT

  echo "\"`date +%Y-%m-%d\ %H:%M`\"" >> $OUTPUT

  tail -n 1 $OUTPUT

done

##

cat $OUTPUT
