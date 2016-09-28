#!/bin/bash

#$ -l h_vmem=32g,h_rt=12:00:00
#$ -pe mpi 1


lang="en"
file=/home/lvapeab/smt/tasks/wmt14/DATA/train.${lang}
dest=/home/lvapeab/smt/tasks/wmt14/DATA/training.${lang}



#cat ${file} | /home/lvapeab/smt/software/moses-git/scripts/tokenizer/lowercase.perl | /home/lvapeab/smt/software/moses-git/scripts/tokenizer/tokenizer.perl -threads 16 -l ${lang} > ${dir}/${task}.tok.${lang}


cat $file | /home/lvapeab/smt/software/mosesdecoder/scripts/tokenizer/tokenizer.perl -l ${lang} >  ${dest}