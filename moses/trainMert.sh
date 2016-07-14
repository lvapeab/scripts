#$ -pe mpi 1 
#$ -l h_vmem=6g,h_rt=144:00:00


#rm -rf /home/lvapeab/smt/tasks/xerox/minieuroparl/MOSES/moses/mert-workOxLM/*
#rm -rf /home/lvapeab/smt/tasks/minieuroparl/MOSES/moses/mert-work-5gram/

/home/lvapeab/smt/software/moses-git/scripts/training/mert-moses.pl /home/lvapeab/smt/tasks/xerox/enes/DATA/dev.en /home/lvapeab/smt/tasks/xerox/enes/DATA/dev.es \
/home/lvapeab/smt/software/moses-git/bin/moses /home/lvapeab/smt/tasks/xerox/enes/MOSES/model/moses.ini \
--mertdir /home/lvapeab/smt/software/moses-git/bin \
--rootdir /home/lvapeab/smt/software/moses-git/scripts \
--working-dir=/home/lvapeab/smt/tasks/xerox/enes/MOSES/model/mert-work \
-decoder-flags "-feature-name-overwrite \"SRILM KENLM\"" 

sed ":a;N;$bash;s/\"SRILM\nKENLM/\"SRILM KENLM\"/" /home/lvapeab/smt/tasks/xerox/enes/MOSES/model/mert-work/moses.ini> /home/lvapeab/smt/tasks/xerox/enes/MOSES/model/mert-work/moses-srilm.ini