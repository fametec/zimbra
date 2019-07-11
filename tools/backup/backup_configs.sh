#!/bin/bash

## Debug
# set -xv
#


DESTINATION=/opt/zimbra/backup/config/

NOW=`date +%Y%m%d%H%M`


if [ ! -d $DESTINATION ]
then

        mkdir -p $DESTINATION

        chown zimbra:zimbra $DESTINATION

fi

TEMPDIR=`mktemp -d`

echo -n "Backup configs to $DESTINATION/configs-$NOW.tar.gz ... " 

su - zimbra -c "zmlocalconfig --show" > $TEMPDIR/zmlocalconfig.txt

cd /opt/zimbra

tar -zcf $DESTINATION/configs-$NOW.tar.gz \
        config.* \
        conf \
        common/conf \
        backup/scripts \
        ssl \
        zimlets \
        $TEMPDIR/zmlocalconfig.txt


if [ $? -eq 0 ]
then

        echo "done"

else

        echo "fail"
        exit 1

fi

rm -rf $TEMPDIR
