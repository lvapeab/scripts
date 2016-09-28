#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_vmem=64g

SRILMDIR=/home/lvapeab/smt/software/srilm/bin/i686-m64
train=/home/lvapeab/smt/tasks/europarl/DATA/news/news.tok.en
test=/home/lvapeab/smt/tasks/europarl/esen/DATA/dev.en
dest=/home/lvapeab/smt/tasks/europarl/esen/LM/5gram.news.en





for order in 5
do
${SRILMDIR}/ngram-count -text ${train} -order $order -lm $dest.${order} -kndiscount -interpolate -unk -gt3min 0 -gt4min 0 -gt5min 0

echo "$order"
echo ""
${SRILMDIR}/ngram -lm $dest.${order} -order $order -ppl ${test} -unk 

done