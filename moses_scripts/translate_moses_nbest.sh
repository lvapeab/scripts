#!/bin/bash
#$ -l h_vmem=16g,h_rt=5:00:00                                                                                                                                                                                                 
#$ -pe mpi 8 

model=/home/lvapeab/smt/tasks/ue/esen/MOSES/model/mert-work/moses-srilm.ini
input=/home/lvapeab/smt/tasks/ue/esen/DATA/test.es
output=/home/lvapeab/smt/tasks/ue/esen/MOSES/model/test_2500

mkdir -p ${output}
/home/lvapeab/smt/software/moses-git/bin/moses -feature-name-overwrite "SRILM KENLM" -f $model --n-best-list $output/5000best 5000 --threads 8 < $input > $output/test.5000.hyp.en 