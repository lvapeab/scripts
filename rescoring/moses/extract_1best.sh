#!/bin/bash



NBDIR=$1
outpref=$2
echo -n "" > ${outpref}.corpus

for nbl in `ls -l  ${NBDIR}/*.reranked  |awk '{print $9}'|sort -V`; do
    
    head -n 1  ${nbl} | awk  'BEGIN{ FS ="\\|\\|\\|"} ; { print$2;} '|tr -s " "  | sed -e 's/^[ \t]*//'>> ${outpref}.corpus
    
done
