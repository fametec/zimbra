#!/bin/bash
#
su – zimbra -c 'zmproxyctl stop'
#
docker run -it --rm \
-p 80:80 \
-p 443:443 \
-v $(pwd):/etc/letsencrypt \
certbot/certbot \
--standalone renew
#
su – zimbra -c 'zmproxyctl start'
EOF


cat <<EOF > expand-cert.sh 
#!/bin/bash
#
su – zimbra -c 'zmproxyctl stop'
#
docker run -it --rm \
-p 80:80 \
-p 443:443 \
-v $(pwd):/etc/letsencrypt \
certbot/certbot \
certonly --standalone --expand \
-d mail.poc.eftech.com.br \
-d novo.poc.eftech.com.br
#
su – zimbra -c 'zmproxyctl start'
