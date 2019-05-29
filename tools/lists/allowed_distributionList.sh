#!/bin/bash
#!/bin/bash
#===============================================================================
#
#          FILE:  add_distributionlist.sh
# 
#         USAGE:  ./add_distributionlist.sh 
# 
#   DESCRIPTION:  Identifica as contas que tem permissao para enviar emails para
#                 a lista DISTRIBUCTION_LIST
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  Executar como usuario zimbra (su - zimbra) 
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  ---
#       COMPANY:  ---
#       VERSION:  1.0
#       CREATED:  23-06-2014 10:59:53 BRT
#      REVISION:  ---
#===============================================================================

DISTRIBUCTION_LIST=mensagem@fametec.com.br

for ACCOUNT in `zmprov -l gaa`
do

   zmprov ckr dl ${DISTRIBUCTION_LIST} ${ACCOUNT} sendToDistList | grep -i ALLOWED &> /dev/null

   if [ $? -eq 0 ]; then

	echo $ACCOUNT >> accounts_allowed_send_to_${DISTRIBUCTION_LIST}.txt

   fi

done


