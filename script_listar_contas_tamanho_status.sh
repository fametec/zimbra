#!/bin/bash
#
###############################################################################
#
# Este script gera um arquivo CSV contendo todas a 
# Contas, Tamanho e Status do servidor Zimbra
# 
# Versão 1.0 2017-12-01 Criação
#
# Autor: Eduardo Fraga <eduardo@eftech.com.br>
#
# Licença: GPLv3
#
###############################################################################

## DEBUG
# set -x

## VARIAVEIS
OUTPUT=/opt/zimbra/backup/contas_tamanho_status.csv
CONTAS="`zmprov -l gaa | sort`"


##  

echo '"Contas","Tamanho","Status"' > $OUTPUT
for i in $CONTAS
do
  MBOXSIZE=`zmmailbox -z -m $i gms`
  STATUS=`zmprov -l ga $i | grep ^zimbraAccountStatus | cut -f2 -d " "`
  echo -n "\"$i\"," >> $OUTPUT
  echo -n "\"$MBOXSIZE\"," >> $OUTPUT
  echo "\"$STATUS'\"" >> $OUTPUT
done

## 


