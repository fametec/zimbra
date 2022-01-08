#!/bin/bash

set -x

if [ "$USER" != "zimbra" ]
then
  echo "Run this script with Zimbra user only" 
  exit 1
fi

if [ ! -d /opt/zimbra/ssl/letsencrypt ]; 
then
  echo -n "Create directory /opt/zimbra/ssl/letsencrypt ... "
  mkdir -p /opt/zimbra/ssl/letsencrypt 
  if [ $? -eq 0 ]; then 
    echo "done"
  else
    echo "error"
    exit 1
  fi
fi

cd /opt/zimbra/ssl/letsencrypt || exit 1

if [ ! -e /opt/zimbra/ssl/letsencrypt/isrgrootx1.pem ]
then 
  echo -n "Download isrgrootx1.pem ... "
  curl -OL https://letsencrypt.org/certs/isrgrootx1.pem
  if [ $? -eq 0 ]; 
  then 
    echo "done"
  else 
    echo "fail"
    exit 2
  fi
fi

if [ ! -e /opt/zimbra/ssl/letsencrypt/lets-encrypt-r3.pem ]
then 
  echo -n "Download lets-encrypt-r3.pem ... "
  curl -OL https://letsencrypt.org/certs/lets-encrypt-r3.pem
  if [ $? -eq 0 ]; 
  then 
    echo "done"
  else 
    echo "fail"
    exit 2
  fi
fi

if [ -e isrgrootx1.pem ] && [ -e lets-encrypt-r3.pem ] && [ -e chain.pem ]
then
  echo -n "Generate chain-ca.pem ..." 
  cat isrgrootx1.pem lets-encrypt-r3.pem chain.pem > chain-ca.pem
  echo "done"
else
  echo "Files isrgrootx1.pem lets-encrypt-r3.pem chain.pem not found, exit"
  exit 2
fi

echo "Verify certificate"
/opt/zimbra/bin/zmcertmgr verifycrt comm privkey.pem cert.pem chain-ca.pem || exit 3

echo "Deploy certificate"
cp -f /opt/zimbra/ssl/letsencrypt/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key || exit 4

/opt/zimbra/bin/zmcertmgr deploycrt comm cert.pem chain-ca.pem || exit 5

echo "Verifiy deploy"
/opt/zimbra/bin/zmcertmgr viewdeployedcrt || exit 6

zmcontrol restart || exit 7

zmcontrol status 
