#!/bin/bash
# 
# set -x
# Requirements: ssh-keygen and ssh-copy-id

ZIMBRASOURCE=10.0.0.30

ACCOUNTS=`ssh $ZIMBRASOURCE 'su - zimbra -c "zmprov -l gaa"'`


testSshConnect() {

  echo -n 'Test ssh...'

  ssh $ZIMBRASOURCE 'exit'

  if [ $? -ne 0 ]; then
    echo "fail"
    exit 1
  fi

  echo "done"

}


remoteExportSignature() {

    if [ -z $1 ] || [ -z $2 ] ; then
       echo "Use: $0 account"
       return 1
    fi

    echo -n "Exporting signature of $1 ..."


    echo "'" > $2

    ssh $ZIMBRASOURCE "su - zimbra -c 'zmprov -l ga '$1' zimbraPrefMailSignature'" | grep -v "#" | sed s/'zimbraPrefMailSignature: '//g >> $2

    echo "'" >> $2

    if [ $? -ne 0 ]; then
       echo "fail"
       return 2 
    else 
       echo "done"
    fi


    echo "'" > ${2}.html

    ssh $ZIMBRASOURCE "su - zimbra -c 'zmprov -l ga '$1' zimbraPrefMailSignatureHTML'" | grep -v "#" | sed s/'zimbraPrefMailSignatureHTML: '//g >> ${2}.html

    echo "'" >> ${2}.html 

    if [ $? -ne 0 ]; then
       echo "fail"
       return 2 
    else 
       echo "done"
    fi

}


deploySignature() {
    
    if [ -z $1 ] || [ -z $2 ] ; then
       echo "Use: $0 account path_of_signature.txt"
       return 1
    fi

    echo -n "Deploy signature of the $1 from $2 ..."

    su - zimbra -c "zmprov -l ma ${1} zimbraPrefMailSignatureEnabled TRUE zimbraPrefMailSignature `cat $2`"

    if [ $? -ne 0 ]; then
      echo "fail"
      echo $1 >> /tmp/signaturefail.txt
      return 3
    else 
      echo "done"
    fi

    su - zimbra -c "zmprov -l ma ${1} zimbraPrefMailSignatureEnabled TRUE zimbraPrefMailSignatureHTML `cat ${2}.html`"

    if [ $? -ne 0 ]; then
      echo "fail"
      echo $1 >> /tmp/signaturehtmlfail.txt
      return 3
    else 
      echo "done"
    fi

    echo -ne "Adding SignatureID to account: $1 \t"

    signatureid=`su - zimbra -c "zmprov -l ga ${1} zimbraSignatureId" | sed -n '2p' | cut -d : -f 2 | sed 's/^\ //g'`

    su - zimbra -c "zmprov ma ${1} zimbraPrefDefaultSignatureId \"$signatureid\""

    su - zimbra -c "zmprov ma ${1} zimbraPrefForwardReplySignatureId \"$signatureid\""

    su - zimbra -c "zmprov -l ga ${1} zimbraPrefMailSignature"

    su - zimbra -c "zmprov -l ga ${1} zimbraPrefMailSignatureHTML"

}

for i in $ACCOUNTS; do
  
  testSshConnect
  remoteExportSignature $i /tmp/signature.txt
  deploySignature $i /tmp/signature.txt

done


