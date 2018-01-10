#!/bin/bash

destdir=`dirname $1`
base=`basename $1`
basename="${base%.*}"

cat $1 |grep WSR |awk '{
    if (NF > 33) {
                 print substr($7, 1, length($7)-1)" "substr($17, 1, length($17)-1) " "substr($20, 1, length($20)-1)
                 } 
    else{ if (NF > 10) {
                 print substr($7, 1, length($7)-1)" "substr($17, 1, length($17)-1)
    }
    }
}'  > ${destdir}/${basename}.scores
