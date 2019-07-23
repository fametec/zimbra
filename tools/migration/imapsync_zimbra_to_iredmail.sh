#!/bin/bash

# Required: imapsync

# Example: account@domain:password 
ACCOUNTS="account@domain:password1
account2@domain:password2"

HOST1=12.12.12.12
HOST2=34.34.34.34


for account in $ACCOUNTS
do
        email=$(echo $account | cut -d ":" -f 1)
        pass=$(echo $account | cut -d ":" -f 2)


        imapsync --host1 $HOST1 \
                --user1 $email \
                --authuser1 ZimbraAdminUser@domain \
                --password1 'ZimbraAdminPassword' \
                --ssl1 \
                --sslargs1 SSL_verify_mode=0 \
                --host2 $HOST2 \
                --user2 $email \
                --authuser2 $email \
                --password2 "$pass" \
                --ssl2 \
                --sslargs2 SSL_verify_mode=0

done


