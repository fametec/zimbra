#!/bin/bash

# set -xv

SOURCE_LIST=/opt/zimbra/backup/lists


for list in `ls $SOURCE_LIST | sed s/'.txt'//`

do

    echo "Deploy ${list}..."

    zmprov -l createDistributionList ${list} 

    echo "done"

    for member in `cat ${SOURCE_LIST}/${list}.txt`

    do

          echo "Add $member in $list ..."

          zmprov -l addDistributionListMember $list $member 

          echo "done" 

    done

done




