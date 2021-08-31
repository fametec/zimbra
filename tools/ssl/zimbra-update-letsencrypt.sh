#!/bin/bash

set -x

DOMAIN=hostname.yourdomain.com

if [ ! -d /opt/zimbra/backup/ssl/letsencrypt ] 
then
  mkdir -p /opt/zimbra/backup/ssl/letsencrypt
fi


  cp -f -a /opt/zimbra/ssl/letsencrypt /opt/zimbra/backup/ssl/letsencrypt/letsencrypt.$(date "+%Y%m%d%H%M") || exit 1
  
  certbot renew --pre-hook "su - zimbra -c 'zmproxyctl stop'" --post-hook "su - zimbra -c 'zmproxyctl start'" || exit 2
  
  cd /opt/zimbra/ssl/letsencrypt
  
  cat /etc/letsencrypt/live/${DOMAIN}/chain.pem /root/dst_root_ca_x3.txt > /root/chain-ca.pem 

  cat /root/chain-ca.pem > /etc/letsencrypt/live/${DOMAIN}/chain.pem

  cp -f /etc/letsencrypt/live/${DOMAIN}/* .
  

su - zimbra -c '/opt/scripts/deploy-zimbra-letsencrypt.sh' 




