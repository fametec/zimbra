#!/bin/sh
#===============================================================================
#
#          FILE:  
# 
#         USAGE:  
# 
#   DESCRIPTION:  Backup MySQL Database
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Eduardo Fraga <eduardo@fametec.com.br>
#       COMPANY:  FAMETEC
#       VERSION:  1.0
#       CREATED:  April 26 2019
#      REVISION:  ---
#===============================================================================
#
#Debug
# set -xv
#
#
exec_bkp()
{
if [ -z $1 ]; then 
  echo "use: $0 nome_do_banco"
  exit 1
fi
# Variaveis
# vB="--all-databases"                # Todas as base de dados
local databaseName=$1
vBI="/opt/zimbra/common/bin/"                     # Diretorio raiz dos binarios do Mysql     
vD="/opt/zimbra/backup/mysql/"            # Destino do Backup
vE=".sql"                           # extencao do arquivo de saida
vT="`mktemp -d`"  #Diretorio Temporario

vAno=`date +%Y` #Ano
vMes=`date +%m` #Mes
vDia=`date +%d` #Dia
vHor=`date +%H` #Hora
vMin=`date +%M` #Min
vDat="$vAno$vMes$vDia-$vHor$vMin"
vQ=mysql-"$i"-"$vDat$vE"
vA="$vQ".gz
vS="-p5nYodvePtxbdbpayKsuKaDpzH1"
# BACKUP #####################
echo "==================================================="
echo "# Gerando backup MYSQL $i"
echo "# Data   : $vDia / $vMes / $vAno  -  $vHor : $vMin"
echo "# Destino: $vD"
echo "# Nome do arquivo: $vA"
# echo "Comando --> $vBI""mysqldump  --single-transaction  -uroot $vS $i > $vD$vA"
# $vBI""mysqldump  --single-transaction  -uroot $vS $i > $vD$vA
# alterado por Francisco em 25-11-2013, valor original acima
"$vBI"mysqldump --socket=/opt/zimbra/data/tmp/mysql/mysql.sock --single-transaction --routines -uroot $vS $databaseName > $vT/$vQ
if [ $? -eq 0 ]; then 
  echo "# BACKUP MYSQL $vA Finalizado com sucesso!" 
  echo "===================================================" 
else 
  echo "# BACKUP MYSQL $vA Falhou, saindo..." 
  echo "===================================================" 
  exit 1 
fi 
gzip -c $vT/$vQ > $vD$vA
if [ ! $? -eq 0 ]; then
  echo "# Erro ao compactar $vA "
  exit 2
else
  if [ -d $vT ]; then 
   rm -rf $vT
  fi
fi
}
# Fim da Funcao exec_bkp
# Inicio do script de backup que chama a funcao exec_bkp
bancodados="$(mysql --socket=/opt/zimbra/data/tmp/mysql/mysql.sock -uroot -p5nYodvePtxbdbpayKsuKaDpzH1 -Bse 'show databases')"
for i in $bancodados;
do
 exec_bkp $i
done;
