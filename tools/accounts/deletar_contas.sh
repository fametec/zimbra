#!/bin/bash
#
#
# 1) Fazer o backup e excluir contas conforme lista de e-mails em anexo (1);
# 2) Excluir mensagens com mais de 2 anos, exceto diretores, em anexo (2) ; 
# 3) Manter mensagens dos diretores; 
# 
# Referencias: 
# https://wiki.zimbra.com/wiki/Deleting_messages_from_account_using_the_CLI
#
## Debug
# set -x
#
# VARIAVEIS
CONTAS_EXCLUIR=`cat /opt/zimbra/backup/contas_excluir.txt`
CONTAS_DIRETORES=`cat /opt/zimbra/backup/contas_diretores.txt`
CONTAS=`zmprov -l gaa | sort`
BKP_DESTINO="/contas01/contas"
#
#
# EXECUTAR SCRIPT COM USUARIO ZIMBRA

if [ ! $USER == "zimbra" ] ; then
  echo "Execute o script com usuario Zimbra: su - zimbra -c \'$0\'"
  exit 1
fi

#
# 
#
## FAZER BACKUP E EXCLUIR EXCLUIR CONTAS

for i in ${CONTAS_EXCLUIR}
do
  echo "backup da conta ${i}"
  su - zimbra -c "zmmailbox -z -m ${i} gru \"//?fmt=tgz\" > ${BKP_DESTINO}/${i}.tgz"
  if [ $? -ne 0 ]; then
    echo "Erro no backup da conta ${i}, conta nao serah excluida" 
  else 
    echo -n "Excluindo conta ${i} ..." 
    zmprov -l da ${i}
    if [ $? -eq 0 ]; then " Ok!"; else " Falhou!"; fi
  fi
done


