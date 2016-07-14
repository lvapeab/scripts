#!/bin/bash

SRILM_DIR=/home/lvapeab/smt/software/srilm/bin/i686-m64
FDA_DIR=/home/lvapeab/smt/software/fda

OUT_DIR=$1 


src_training=$2
trg_training=$3

src_test=$4
trg_test=$5

vocab= ""


#OUT_DIR=/home/lvapeab/smt/tasks/xerox/enes/DATA/reduced/selection_sampling
#src_training=/home/lvapeab/smt/tasks/xerox/enes/DATA/En
#trg_training=/home/lvapeab/smt/tasks/xerox/enes/DATA/latin/Es
#src_test=/home/lvapeab/smt/tasks/xerox/enes/DATA/En-test
#trg_test=/home/lvapeab/smt/tasks/xerox/enes/DATA/latin/Es-test




mkdir -p ${OUT_DIR}

# echo -n ""> ${OUT_DIR}/stats
for n_words in 5000 30000 60000 80000 120000 350000 450000 550000 650000  0;
do
    echo "Computing selection using $n_words"
    ${FDA_DIR}/fda -o ${OUT_DIR}/output -t${n_words} ${src_training} ${src_test} ${trg_training}  ${trg_test}
    
    cat  ${OUT_DIR}/output |awk 'BEGIN {FS="\t";}{print $1}' >  ${OUT_DIR}/out_src_${n_words}
    cat  ${OUT_DIR}/output |awk 'BEGIN {FS="\t";}{print $2}' >  ${OUT_DIR}/out_trg_${n_words}

    for order in 2 3 4 5;
    do
	lm=${OUT_DIR}/en.${order}.lm
	echo "Selection complete. Estimating ${order}-gram LM..."
	${SRILM_DIR}/ngram-count -text ${OUT_DIR}/out_trg_${n_words} -order ${order} -lm ${lm}.${n_words} -kndiscount -interpolate -unk ${vocab}
	echo "Estimation complete. Computing ppl"
	echo "-----------${n_words} words ------------" >>  ${OUT_DIR}/stats_${order}
	wc ${OUT_DIR}/out_src_${n_words} >> ${OUT_DIR}/stats
	${SRILM_DIR}/ngram  -lm  ${lm}.${n_words} -order ${order} -ppl ${trg_test} -unk >>  ${OUT_DIR}/stats_${order}
    done
done 
