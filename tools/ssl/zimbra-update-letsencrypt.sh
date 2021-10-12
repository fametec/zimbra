#!/bin/bash

set -x

DOMAIN=hostname.yourdomain.com

if [ ! -d /opt/zimbra/backup/ssl/letsencrypt ] 
then
  mkdir -p /opt/zimbra/backup/ssl/letsencrypt
fi


  cp -f -a /opt/zimbra/ssl/letsencrypt /opt/zimbra/backup/ssl/letsencrypt/letsencrypt.$(date "+%Y%m%d%H%M") || exit 1
  
  certbot --preferred-chain  "ISRG Root X1" renew --pre-hook "su - zimbra -c 'zmproxyctl stop'" --post-hook "su - zimbra -c 'zmproxyctl start'" || exit 2
  
  cd /opt/zimbra/ssl/letsencrypt
  
  cat isrgrootx1.pem lets-encrypt-r3.pem /etc/letsencrypt/live/${DOMAIN}/chain.pem > chain-ca.pem 

  cp -f /etc/letsencrypt/live/${DOMAIN}/* .
  
  chown zimbra:zimbra /opt/zimbra/ssl/letsencrypt

su - zimbra -c '/opt/scripts/deploy-zimbra-letsencrypt.sh' 




