#!/bin/bash
#
#===============================================================================
#
#          FILE:  block_account.sh
# 
#         USAGE:  ---
# 
#   DESCRIPTION:  ---
#                 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Eduardo Fraga <eduardo@fametec.com.br>
#       COMPANY:  FAMETEC
#       VERSION:  1.0
#       CREATED:  April 26 2019
#      REVISION:  ---
#===============================================================================
#
#===============================================================================
#Debug
# set -xv
#
#===============================================================================


for i in $(cat contas180dias.txt)
do
  /opt/zimbra/bin/zmprov ma $i zimbraAccountStatus locked
  if [ $? -eq 0 ]; then 
    echo "Account $i locked"
  fi
done
