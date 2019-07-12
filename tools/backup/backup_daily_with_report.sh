#!/bin/bash
#
## DEBUG
# set -x

# Require: backup_account_daily.sh

BACKUP_DIR=/opt/zimbra/backup/accounts

STARTTIME1=$(date -d '-1 day' +%Y-%m-%d)

OUTPUT=$BACKUP_DIR/backup_report-${STARTTIME1}.csv

if [ -z $1 ]; then
        ACCOUNTS="`su - zimbra -c "zmprov -l gaa" | sort`"
else
        ACCOUNTS=$1
fi


if [ -x backup_account_daily.sh ]
then

  echo "Error: backup_account_daily.sh not found. "

fi


echo '"start_date","account","backup_size","end_date"' > $OUTPUT

for i in $ACCOUNTS

do

  echo -n "\"`date +%Y-%m-%d\ %H:%M`\"," >> $OUTPUT

  echo -n "\"$i\"," >> $OUTPUT

  ./backup_account_daily.sh $i "$BACKUP_DIR"

  echo -n "\"`ls -lh $BACKUP_DIR/${i}/${i}-${STARTTIME1}.tgz | cut -d ' ' -f 5` \"," >> $OUTPUT

  echo "\"`date +%Y-%m-%d\ %H:%M`\"" >> $OUTPUT

  tail -n 1 $OUTPUT

done

##

cat $OUTPUT
