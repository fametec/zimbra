#!/bin/bash



# Fonte: https://wiki.zimbra.com/wiki/King0770-Notes-Find_Out_When_Message_Was_Read



OUT=/opt/zimbra/backup/contas_change_date.csv

CONTAS=`zmprov -l gaa | sort`


echo '"Contas","Change_date"' > $OUT

for i in $CONTAS
do

 MBOXID=`zmprov gmi $i | grep mailboxId | cut -f2 -d " "`
 MBOXGROUP=`expr $MBOXID % 100`
 MBOXDB=mboxgroup$MBOXGROUP
 QUERY=`mysql -s -r -N -e "select max(change_date) from $MBOXDB.mail_item where mailbox_id=$MBOXID \G" | sed /row/d`
 DATA=`perl -e 'print localtime('$QUERY'). "\n"'`

 echo "\"$i\"",\"$DATA\"" >> $OUT

 echo $i

done

echo " "
echo "Lista gravada em: $OUT"


