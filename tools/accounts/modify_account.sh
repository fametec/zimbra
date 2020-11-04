#!/bin/bash
#
# modify_account.sh
# Simple shell script that modify attributes likes cn, displayName and zimbraPrefFromDisplay.
#
# use: ./modify_account.sh
#
# Require contas.csv CSV file example:
# email,Name
# eduardo@fametec.com.br,Eduardo Fraga
# alexandre@fametec.com.br,Alexandre Muzzio
#
# debug
#set -x

for i in `cat contas.csv | cut -d, -f1`
do
  NAME=`grep $i contas.csv | cut -d, -f2`
  su - zimbra -c "zmprov modifyAccount $i cn \"$NAME\" displayName \"$NAME\" zimbraPrefFromDisplay \"$NAME\""
done

