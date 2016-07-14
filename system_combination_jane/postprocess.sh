#!/bin/bash

if [ $# -ne 1 ] 
then
    echo "usage: preprocess.sh <file>"
    exit 1
fi

cat $1 |sed -e "s/<percentage>/%/g" -e "s/<hash>/#/g" -e "s/<dollar-symbol>/$/g" 