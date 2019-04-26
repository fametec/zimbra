#!/bin/bash
# 
set -x
# Fonte: https://wiki.zimbra.com/wiki/Outgoing_SMTP_Authentication
#
MAIL_SERVER=mail.treinamento.eftech.com.br
MAILGUN_USER=xxxxxx
MAILGUN_PASS=yyyyyy
#
zmprov ms $MAIL_SERVER zimbraMtaRelayHost [smtp.mailgun.org]:587
echo [smtp.mailgun.org]:587 $MAILGUN_USER:$MAILGUN_PASS > /opt/zimbra/conf/relay_password
postmap /opt/zimbra/conf/relay_password 
postmap -q [smtp.mailgun.org]:587 /opt/zimbra/conf/relay_password
zmprov ms $MAIL_SERVER zimbraMtaSmtpSaslPasswordMaps lmdb:/opt/zimbra/conf/relay_password
zmprov ms $MAIL_SERVER zimbraMtaSmtpSaslAuthEnable yes
zmprov ms $MAIL_SERVER zimbraMtaSmtpCnameOverridesServername no
zmprov ms $MAIL_SERVER zimbraMtaSmtpTlsSecurityLevel may
postmap /opt/zimbra/conf/relay_password 
zmprov ms $MAIL_SERVER zimbraMtaSmtpSaslSecurityOptions noanonymous



