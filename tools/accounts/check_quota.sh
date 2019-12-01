#!/bin/bash
#
###############################################################################
#
# Este script envia um e-mail para o suporte caso a quota do usuario estiver 
# proxima de encher 
# 
# Versão 1.0 2097-12-01 Criaço
#
# Autor: Eduardo Fraga <eduardo@eftech.com.br>
#
# Instalação: 
# crontab -e
#
# 0 1 * * * /opt/zimbra/backup/check_quota.sh >/dev/null 2>&1
#
# Licença: GPLv3
#
###############################################################################

## DEBUG
# set -x

## VARIAVEIS

SUPPORT=eduardo@fametec.com.br

QUOTAS=$(zmprov getQuotaUsage `zmhostname` | sed s/' '/,/g)
#QUOTAS="account1@domain.com,1073741824,0
#account2@domain.com,1073741824,1073741824
#account3@domain.com,1073741824,1063741824"

##  

for i in $QUOTAS
do

   ACCOUNT=$(echo $i | cut -d , -f1)
   QUOTA=$(echo $i | cut -d , -f2 )
   SIZE=$(echo $i | cut -d , -f3)

   RESULT=`expr 100 \* $SIZE / $QUOTA`

   if [ ! -z $RESULT ] && [ $RESULT -gt 90 ]
   then

      echo "Subject: Alerta $ACCOUNT quota" > /tmp/msg.txt
          echo "Alerta, $ACCOUNT esta com ${RESULT}% de uso." >> /tmp/msg.txt
          
          sendmail -f admin@`zmhostname` -v $SUPPORT < /tmp/msg.txt

   fi

done
