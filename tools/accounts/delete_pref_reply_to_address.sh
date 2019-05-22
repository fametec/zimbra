#!/bin/bash

set -x

ACCOUNTS=`zmprov -l gaa`


for i in $ACCOUNTS
do
  zmprov -l ga $i zimbraPrefReplyToAddress zimbraPrefReplyToDisplay zimbraPrefReplyToEnabled

  zmprov -l ma $i zimbraPrefReplyToDisplay $i

  zmprov -l ma $i -zimbraPrefReplyToDisplay $i

  zmprov -l ma $i zimbraPrefReplyToAddress $i

  zmprov -l ma $i -zimbraPrefReplyToAddress $i

  zmprov -l ma $i -zimbraPrefReplyToEnabled TRUE

  zmprov -l ma $i -zimbraPrefReplyToEnabled FALSE

  zmprov -l ga $i zimbraPrefReplyToAddress zimbraPrefReplyToDisplay zimbraPrefReplyToEnabled

done
