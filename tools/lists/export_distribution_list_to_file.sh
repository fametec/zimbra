#!/bin/bash

#Debug
# set -xv

DESTINATIONLIST=/opt/zimbra/backup/lists

if [ ! -d $DESTINATION ]
then

    mkdir -p $DESTINATION

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



for item in $(getAllDistributionList)
do
    
    getDistributionListMembership $item >> ${DESTINATION}/${item}.txt 

    echo "Distribution list exported to ${DESTINATION}/${item}.txt"
    
done

