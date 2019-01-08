#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Usage: $0 text_file"
    echo "Processes an al-inmt log (NMT-Keras) and outputs the original hypotheses"
    exit 1
fi

for file in  $* ;do
    grep  -e "\] Source: " ${file} |awk 'BEGIN{FS=":"}{ for(i=4; i<NF; i++) printf "%s",$i OFS; if(NF) printf "%s",$NF; printf ORS}'
done
