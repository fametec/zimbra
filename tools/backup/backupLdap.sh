#!/bin/bash
/opt/zimbra/libexec/zmslapcat /opt/zimbra/backup/ldap
/opt/zimbra/libexec/zmslapcat -c /opt/zimbra/backup/ldap
/opt/zimbra/libexec/zmslapcat -a /opt/zimbra/backup/ldap
