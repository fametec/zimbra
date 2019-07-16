#!/bin/bash
#
set -x
#
MAIL_SERVER=`zmhostname`
MAIL_USERNAME=postmaster@dddddd.ddd.dd
MAIL_PASSWORD=zzzzyyyyaaaa
#
#
zmprov ms $MAIL_SERVER zimbraMtaRelayHost [smtp.mailgun.org]:587
echo [smtp.mailgun.org]:587 $MAIL_USERNAME:"$MAIL_PASSWORD" > /opt/zimbra/conf/relay_password
postmap /opt/zimbra/conf/relay_password
postmap -q [smtp.mailgun.org]:587 /opt/zimbra/conf/relay_password
zmprov ms $MAIL_SERVER zimbraMtaSmtpSaslPasswordMaps lmdb:/opt/zimbra/conf/relay_password
zmprov ms $MAIL_SERVER zimbraMtaSmtpSaslAuthEnable yes
zmprov ms $MAIL_SERVER zimbraMtaSmtpCnameOverridesServername no
zmprov ms $MAIL_SERVER zimbraMtaSmtpTlsSecurityLevel may
postmap /opt/zimbra/conf/relay_password
zmprov ms $MAIL_SERVER zimbraMtaSmtpSaslSecurityOptions noanonymous


# Fonte: https://wiki.zimbra.com/wiki/Outgoing_SMTP_Authentication

