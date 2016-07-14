#!/bin/bash


SRILM_DIR=/home/alvaro/smt/software/srilm/bin/i686-m64
INF_DIR=/home/alvaro/smt/software/infreq


OUT_DIR=$1 


src_training=$2
trg_training=$3


src_test=$4
trg_test=$5


vocab="" #"-voc /home/alvaro/smt/tasks/ue/reduced/infreq/voc_inf"

mkdir -p ${OUT_DIR}

# echo -n ""> ${OUT_DIR}/stats
for t in 1 5 10 15 20 25 30 40 60 80 100 300 500 ;
do
    echo "Computing selection using $t"
    ${INF_DIR}/infreq_sin_indomain.sh 5 ${src_test} $t ${src_training} ${trg_training} ${OUT_DIR}  
    

    for order in  2 3 4 5;
    do
	lm=${OUT_DIR}/en.${order}.lm
	echo "Selection complete. Estimating ${order}-gram LM"
	${SRILM_DIR}/ngram-count -text ${OUT_DIR}/out_trg_${t} -order ${order} -lm ${lm}.${t} -kndiscount -interpolate  -unk ${vocab}
	echo "Estimation complete. Computing ppl"
	echo "-----------${t} words ------------" >>  ${OUT_DIR}/stats_${order}
	wc ${OUT_DIR}/out_src_${t} >> ${OUT_DIR}/stats
	${SRILM_DIR}/ngram  -lm  ${lm}.${t} -order ${order} -ppl ${trg_test} -unk >>  ${OUT_DIR}/stats_${order}
    done
done 
