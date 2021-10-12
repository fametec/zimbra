#!/bin/bash
#
su – zimbra -c 'zmproxyctl stop'
#
docker run -it --rm \
-p 80:80 \
-p 443:443 \
-v $(pwd):/etc/letsencrypt \
certbot/certbot \
--standalone --preferred-chain  "ISRG Root X1" renew
#
su – zimbra -c 'zmproxyctl start'
