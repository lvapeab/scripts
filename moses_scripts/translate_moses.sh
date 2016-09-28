#!/bin/bash
#$ -l h_vmem=32g,h_rt=24:00:00  
#$ -pe mpi 4

model=/home/lvapeab/smt/tasks/europarl/esen/MOSES/mert/moses-srilm.ini
input=/home/lvapeab/smt/tasks/europarl/esen/DATA/test.es
filter_dir=/home/lvapeab/filtered
output=/home/lvapeab/europarl.hyp.en

mkdir -p `dirname ${output}`

echo "Starting translation process..."

/home/lvapeab/smt/software/moses-git/bin/moses  -feature-name-overwrite "SRILM KENLM" -f ${model} < $input > $output

echo "Translation process finished"