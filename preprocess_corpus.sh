#!/bin/bash

if [ $# -ne 6 ]; then
    echo "Usage: `basename $0` corpus_1 corpus_2 l1 l2 n_sents_val n_sents_test"
    echo "Lowercases, tokenizes, cleans, shuffles and splits the given corpora" 
    echo "example:`basename $0` training.es training.en es en 500 1000"
    exit 1
fi

moses_dir=/home/lvapeab/smt/software/mosesdecoder

corpus1=$1
corpus2=$2
l1=$3
l2=$4
ndev=$5
ntest=$6

c1_n=`basename $corpus1`
c2_n=`basename $corpus2`

destdir=`dirname $corpus1`

echo "Lowercasing"
${moses_dir}/scripts/tokenizer/lowercase.perl < ${corpus1} > /tmp/${c1_n}.low
${moses_dir}/scripts/tokenizer/lowercase.perl < ${corpus2} > /tmp/${c2_n}.low
echo "Tokenizing"
${moses_dir}/scripts/tokenizer/tokenizer.perl -l ${l1} -threads 4 <  /tmp/${c1_n}.low  >  /tmp/${c1_n}.tok.${l1}
${moses_dir}/scripts/tokenizer/tokenizer.perl -l ${l2} -threads 4 <  /tmp/${c2_n}.low  >  /tmp/${c1_n}.tok.${l2}

echo "Cleaning corpus"
${moses_dir}/scripts/training/clean-corpus-n.perl /tmp/${c1_n}.tok ${l1} ${l2} /tmp/train 1 80

echo "Shuffling"
thot_shuffle 4311 /tmp/train.${l1}  > /tmp/tr.${l1}
thot_shuffle 4311 /tmp/train.${l2}  > /tmp/tr.${l2}

echo "Splitting"
head -n $ndev  /tmp/tr.${l1} > ${destdir}/dev.${l1}
head -n $ndev  /tmp/tr.${l2} > ${destdir}/dev.${l2}
tail -n +${ndev} /tmp/tr.${l1}  > /tmp/tr2.${l1}
tail -n +${ndev} /tmp/tr.${l2}  > /tmp/tr2.${l2}

head -n $ntest  /tmp/tr2.${l1} > ${destdir}/test.${l1}
head -n $ntest  /tmp/tr2.${l2} > ${destdir}/test.${l2}
tail -n +${ntest} /tmp/tr2.${l1}  > ${destdir}/training.${l1}
tail -n +${ntest} /tmp/tr2.${l2}  > ${destdir}/training.${l2}


rm /tmp/*.low /tmp/*.tok* /tmp/tr*