#!/bin/bash


# Debug
set -xv


#DOMAINS=`zmprov -l getAllDomains`

DOMAINS="domain-test.com
domain-test.net
domain-test.com.br"

for item in $DOMAINS
do

        echo -n "Creating ${item}... "

        zmprov -l createDomain $item 

        if [ $? -ne 0 ];
	then 

            echo "fail"

        else

            echo "done"

        fi


done
