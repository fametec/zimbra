#!/bin/sh

#Debug
# set -x
#
#

MYSQL_USER=zimbra

MYSQL_PASS=`su - zimbra -c 'zmlocalconfig --format nokey --show zimbra_mysql_password'`

MYSQL_SOCKET=`su - zimbra -c 'zmlocalconfig --format nokey mysql_socket'`

BACKUP_DIR="/backup-zimbra/mysql"

NOW=`date +%Y%m%d%H%M`

exec_bkp() {

        if [ -z $1 ];
        then

                echo "use: $0 nome_do_banco"
                exit 1
        fi

        local databaseName=$1

        if [ ! -d $BACKUP_DIR/$NOW ]
        then
                mkdir -p $BACKUP_DIR/$NOW

                chown zimbra:zimbra $BACKUP_DIR/$NOW

        fi

        /opt/zimbra/common/bin/mysqldump --socket=${MYSQL_SOCKET} -u ${MYSQL_USER} -p${MYSQL_PASS} --single-transaction --routines --databases ${databaseName} > ${BACKUP_DIR}/${NOW}/${databaseName}.sql



        if [ $? -ne 0 ]; then

                echo "$1 Error"

                exit 1

        fi


}



compactar() {

        echo -n "Compactando... "

        tar -zcf ${BACKUP_DIR}/mysql-$NOW.tar.gz ${BACKUP_DIR}/${NOW}

#       tar cf - ${BACKUP_DIR}/${NOW} -P | pv -s $(du -sb ${BACKUP_DIR}/${NOW} | awk '{print $1}') | gzip > ${BACKUP_DIR}/mysql-$NOW.tar.gz

        if [ $? -eq 0 ]; then

            rm -rf ${BACKUP_DIR}/${NOW}

        fi

        echo "done"

}



echo -n "Backup: "

DATABASES=`su - zimbra -c "mysql -Bse 'show databases'"`

for database in $DATABASES;
do

        exec_bkp $database

        echo -n "#"

done

echo " done!"

compactar



