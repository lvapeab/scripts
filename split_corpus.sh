#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: `basename $0` corpus_1 corpus_2  l1 l2  n_sents [-s]"
    echo "Splits and optionally shuffles the given corpora"
    echo "example:`basename $0` training.es training.en 1000"
    exit 1
fi


shuffle=0

corpus1=$1
corpus2=$2
l1=$3
l2=$4
nsents=$5


while [ $# -ne 0 ]; do
    case $1 in
	"--help") usage
		  exit 0
		  ;;
	"-s") shift
	      shuffle=1
	      ;;
    esac
    shift
done



destdir=`dirname ${corpus1}`


if [ ${shuffle} -eq 1 ]; then
    echo "Shuffling"
    paste $corpus1 $corpus2 > /tmp/tr
    shuf  /tmp/tr > /tmp/tr2
    cut -f 1 /tmp/tr2 >/tmp/c1
    cut -f 2 /tmp/tr2 >/tmp/c2
    corpus1=/tmp/c1
    corpus2=/tmp/c2
    rm /tmp/tr /tmp/tr2
fi


echo "Splitting"
head -n ${nsents} ${corpus1} > ${destdir}/dev.${l1}
head -n ${nsents} ${corpus2} > ${destdir}/dev.${l2}
tail -n +${nsents} ${corpus1}  > ${destdir}/training.${l1}
tail -n +${nsents} ${corpus2}  > ${destdir}/training.${l2}
