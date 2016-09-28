#!/bin/bash

#$ -l h_vmem=8g,h_rt=5:00:00  
model=/home/lvapeab/smt/tasks/xerox/enes/MOSES/model/mert-work/moses-srilm.ini
input=/home/lvapeab/smt/tasks/xerox/enes/DATA/test.en
output=/home/lvapeab/smt/tasks/xerox/enes/MOSES/test/test-hyp.es

mkdir -p `dirname ${output}`

/home/lvapeab/smt/software/moses-git/bin/moses -feature-name-overwrite "SRILM KENLM" -f $model < $input > $output