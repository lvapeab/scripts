#!/bin/bash
main=$1
backoff=$2
output=$3
lm=$4

if [ $# -ne 4 ];then
    echo "Usage: combine_tm_ppl <test1> <test_2> <output> <lm>"
    exit 0
fi

echo "Computing PPL of `basename ${main}`"
~/smt/software/scripts/tm_combination/write_ppl.sh  ${lm} ${main} >${main}.ppl
echo "Computing PPL of `basename ${backoff}`"
~/smt/software/scripts/tm_combination/write_ppl.sh  ${lm} ${backoff} >${backoff}.ppl
echo "Computing combination"
python ~/smt/software/scripts/tm_combination/combine_tm_ppl.py ${main} ${backoff} ${main}.ppl ${backoff}.ppl -v > ${output}.ppl
