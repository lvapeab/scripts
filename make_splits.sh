#!/bin/bash

if [ $# -lt 5 ]; then
    echo "Usage: `basename $0` corpus_1 corpus_2 l1 l2 n_sents_val n_sents_test"
    echo "Shuffles and splits the given corpora" 
    echo "example:`basename $0` training.es training.en es en 500 1000"
    exit 1
fi

corpus1=$1
corpus2=$2
l1=$3
l2=$4

if [ $# -ge 5 ]; then
    ndev=$5
fi

if [ $# -ge 6 ]; then
    ntest=$6
fi

destdir=`dirname $corpus1`

paste $corpus1 $corpus2 |shuf > /tmp/full_corpus
cat /tmp/full_corpus | awk 'BEGIN{FS="\t"}{print $1}' > /tmp/shuf.${l1}
cat /tmp/full_corpus | awk 'BEGIN{FS="\t"}{print $2}' > /tmp/shuf.${l2}

if [ $# -ge 5 ]; then
    echo "Splitting"
    head -n $ndev  /tmp/shuf.${l1} > ${destdir}/dev.${l1}
    head -n $ndev  /tmp/shuf.${l2} > ${destdir}/dev.${l2}
    tail -n +${ndev} /tmp/shuf.${l1}  > /tmp/shuf2.${l1}
    tail -n +${ndev} /tmp/shuf.${l2}  > /tmp/shuf2.${l2}   
    if [ $# -ge 6 ]; then
	head -n $ntest  /tmp/shuf2.${l1} > ${destdir}/test.${l1}
	head -n $ntest  /tmp/shuf2.${l2} > ${destdir}/test.${l2}
	tail -n +${ntest} /tmp/shuf2.${l1}  > ${destdir}/training.${l1}
	tail -n +${ntest} /tmp/shuf2.${l2}  > ${destdir}/training.${l2}
    else
	mv /tmp/shuf2.${l1} ${destdir}/training.${l1}
	mv /tmp/shuf2.${l2} ${destdir}/training.${l2}
    fi
fi

#rm /tmp/shuf*
