export or import zimbra accounts
2-3 minutes

Export full backup of one zimbra account

zmmailbox -z -m user@domain -t 0 getRestURL "//?fmt=tgz" > /tmp/user@domain.tgz

Export current day backup of one zimbra account*

zmmailbox -z -m user@domain -t 0 getRestURL --startTime $(date -d '-1 day' +%Y/%m/%d) --endTime $(date -d '+1 day' +%Y/%m/%d) "//?fmt=tgz" > /tmp/user@domian.tgz

Export last 7 days backup of one zimbra account*

zmmailbox -z -m user@domain -t 0 getRestURL --startTime $(date -d '-8 day' +%Y/%m/%d) --endTime $(date -d '+1 day' +%Y/%m/%d) "//?fmt=tgz" > /tmp/user@domain.tgz

Export current month backup of one zimbra account*

zmmailbox -z -m user@domain -t 0 getRestURL --startTime $(date -d "-$(date +%d) days -0 month" +%Y/%m/%d) --endTime $(date -d "-$(date +%d) days +1 month +1 day" +%Y/%m/%d) "//?fmt=tgz" > /tmp/user@domain.tgz

Export previous month backup of one zimbra account*

zmmailbox -z -m user@domain -t 0 getRestURL --startTime $(date -d "-$(date +%d) days -1 month" +%Y/%m/%d) --endTime $(date -d "-$(date +%d) days -0 month +1 day" +%Y/%m/%d) "//?fmt=tgz" > /tmp/user@domain.tgz

Import zimbra backup of one account

zmmailbox -z -m user@domain -t 0 postRestURL "//?fmt=tgz&resolve=skip" /tmp/user@domain.tgz

*Set more 1 day on the start and end date because it is not possible to specify the time on the dates

The resolve=paramater has several options:
“skip” ignores duplicates of old items, it’s also the default conflict-resolution
“reset” will delete the old subfolder (or entire mailbox if /)
“modify” changes old items
“replace” will delete and re-enter them

Export LDAP configuration zimbra

/opt/zimbra/openldap/sbin/slapcat -F /opt/zimbra/data/ldap/config -b "" -l /tmp/zimbra-ldap.ldif

Reference: 
https://documentacoes.wordpress.com/2017/11/13/export-or-import-zimbra-accounts/ 
