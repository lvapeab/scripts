#!/bin/bash


LC_NUMERIC="en_US.UTF-8"
METEOR=/home/lvapeab/smt/software/meteor-1.5/meteor*.jar



if [[ ("$1" != "-r" && "$3" != "-r") || ("$1" != "-t" && "$3" != "-t") ]]
then
    >&2 echo "Usage: $0 -r ref -t hyp -l lang"
    exit 1
fi

if [[ "$1" == "-r" ]]
then
    REF=$2
    HYP=$4
else
    REF=$4
    HYP=$2
fi

if [[ "$5" == "-l" ]]
then
    LANG=$6
    
else
    LANG=en
    echo "Warning! Language not selected! Using english"
fi

if [[ ! -f $REF ]]
then
    >&2 echo "File "$REF" does not exist"
    exit 1
fi

if [[ ! -f $HYP ]]
then
    >&2 echo "File "$HYP" does not exist"
    exit 1
fi


java -Xmx2G -jar $METEOR $HYP $REF -l $LANG -norm | grep "Final score" |awk '{print $3}'
