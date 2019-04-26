#!/bin/bash
#
#
# Excluir mensagens com mais de 2 anos, exceto diretores, em anexo ; 
# Manter mensagens dos diretores; 
# 
# Referencias: 
# https://wiki.zimbra.com/wiki/Deleting_messages_from_account_using_the_CLI
#
## Debug
# set -x
#
# VARIAVEIS
CONTAS_DIRETORES=`cat /opt/zimbra/backup/contas_diretores.txt`
# CONTAS=`zmprov -l gaa | sort`

CONTAS="eduardo@eftech.com.br"

ANO=`date +%Y`
ANO2=`expr $ANO - 2`
MES=`date +%m`
DIA=`date +%d`
#
# EXECUTAR SCRIPT COM USUARIO ZIMBRA

if [ ! $USER == "zimbra" ] ; then
  echo "Execute o script com usuario Zimbra: su - zimbra -c \'$0\'"
  exit 1
fi

#
# EXECUTAR A LIMPESA

for j in $CONTAS
do
        MSGID=`zmmailbox -z -m $j s -t message -l 10 "in:inbox before:$DIA/$MES/$ANO2" | cut -d '.' -f2 | cut -d' ' -f 2 | grep -v ^$ | sed  /,/d`
        COUNT=`echo $MSGID | wc -w`

        while [ $COUNT -gt 0  ];  
		do
                for i in $MSGID; 
				do
                        echo "apagando $i..."
                        zmmailbox -z -m $j deleteMessage ${i}
                        if [ $? -ne 0 ] ; then
                                echo "falou"
                        fi
                done

		MSGID=`zmmailbox -z -m $j s -t message -l 10 "in:inbox before:$DIA/$MES/$ANO2" | cut -d '.' -f2 | cut -d' ' -f 2 | grep -v ^$ | sed  /,/d`
		COUNT=`echo $MSGID | wc -w`
				
        done
done





