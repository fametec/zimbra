#!/bin/bash
#
su – zimbra -c 'zmproxyctl stop'
#
docker run -it --rm \
-p 80:80 \
-p 443:443 \
-v $(pwd):/etc/letsencrypt \
certbot/certbot \
certonly --standalone \
--email suporte@fametec.com.br --agree-tos \
--preferred-chain  "ISRG Root X1" \
-d mail.poc.eftech.com.br \
-d smtp.poc.eftech.com.br \
-d zimbra.poc.eftech.com.br \
-d webmail.poc.eftech.com.br \
-d pop.poc.eftech.com.br \
-d imap.poc.eftech.com.br \
--no-eff-email
#
su – zimbra -c 'zmproxyctl start'
