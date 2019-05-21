#!/bin/bash

#Debug
# set -xv

DESTINATIONLIST=/opt/zimbra/backup/lists

if [ ! -d $DESTINATIONLIST ]
then

    mkdir -p $DESTINATIONLIST

fi

getAllDistributionLists() {

    zmprov -l getAllDistributionLists

}


getDistributionListMembership() {

    if [ -z $1 ]; then 
        
        echo "Use: $0 <distributionList>" 
	exit 1
    fi


    zmprov -l getDistributionListMembership $1 | egrep -v '^$|#|members' 

}



for item in $(getAllDistributionLists)
do
    
    getDistributionListMembership $item >> ${DESTINATIONLIST}/${item}.txt 

    echo "Distribution list exported to ${DESTINATIONLIST}/${item}.txt"
    
done

