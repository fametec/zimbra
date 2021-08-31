#!/bin/bash

set -x

if [ $USER -ne 'zimbra' ]
then
  echo "Run this script with Zimbra user only" 
  exit 1
fi


cd /opt/zimbra/ssl/letsencrypt || exit 2

/opt/zimbra/bin/zmcertmgr verifycrt comm privkey.pem cert.pem chain.pem || exit 3

cp -f /opt/zimbra/ssl/letsencrypt/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key || exit 4

/opt/zimbra/bin/zmcertmgr deploycrt comm cert.pem chain.pem || exit 5

zmcontrol restart || exit 6

zmcontrol status 

