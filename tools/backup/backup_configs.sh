#!/bin/bash

DESTINATION=/opt/zimbra/backup/config/

NOW=`date +%Y%m%d%H%M`


if [ ! -d $DESTINATION ]
then

        mkdir -p $DESTINATION

        chown zimbra:zimbra $DESTINATION

fi


cd /opt/zimbra

tar -zcvf $DESTINATION/configs-$NOW.tar.gz \
        config.* \
        conf \
        common \
        backup/scripts \
        ssl \
        zimlets


if [ $? -eq 0 ]
then

        echo "done"

else

        echo "fail"
        exit 1

fi


