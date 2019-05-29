#!/bin/bash
#===============================================================================
#
#          FILE:  add_distributionlist.sh
# 
#         USAGE:  ./add_distributionlist.sh 
# 
#   DESCRIPTION:  Verifica se as contas estão na lista  
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
#
ADDRESS_DISTRIBUTION_LIST=mensagem@fametec.com.br
#
#
for i in $(zmprov -l gaa)
do
        if zmprov gdlm ${ADDRESS_DISTRIBUTION_LIST} | grep ${i}; then
                echo "${i} aread exist, not to do!"
        else
                zmprov adlm ${ADDRESS_DISTRIBUTION_LIST} ${i} 
		        echo "${i} included in ${ADDRESS_DISTRIBUTION_LIST}!"
        fi
done
