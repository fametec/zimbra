#!/bin/sh

# Reference: 
# https://www.systutorials.com/1411/sending-email-from-mailx-command-in-linux-using-gmails-smtp/


MAILX=`which mailx`
$MAILX -v -s "$EMAIL_SUBJECT" \
-S smtp-use-starttls \
-S ssl-verify=ignore \
-S smtp-auth=login \
-S smtp=smtp://smtp.gmail.com:587 \
-S from="$FROM_EMAIL_ADDRESS($FRIENDLY_NAME)" \
-S smtp-auth-user=$FROM_EMAIL_ADDRESS \
-S smtp-auth-password=$EMAIL_ACCOUNT_PASSWORD \
-S ssl-verify=ignore \
$TO_EMAIL_ADDRESS
