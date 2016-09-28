#$ -pe mpi 8 
#$ -l h_vmem=12g,h_rt=144:00:00


model_dir=/home/lvapeab/smt/tasks/europarl/esen/MOSES/model
mert_dir=/home/lvapeab/smt/tasks/europarl/esen/MOSES/mert
data_dir=/home/lvapeab/smt/tasks/europarl/esen/DATA


/home/lvapeab/smt/software/moses-git/scripts/training/mert-moses.pl ${data_dir}/dev.es  ${data_dir}/dev.en \
/home/lvapeab/smt/software/moses-git/bin/moses ${model_dir}/moses.ini \
--mertdir /home/lvapeab/smt/software/moses-git/bin \
--rootdir /home/lvapeab/smt/software/moses-git/scripts \
--working-dir=${mert_dir} \
--nbest=100  \
-decoder-flags "-threads 8 -feature-name-overwrite \"SRILM KENLM\""

sed ":a;N;$bash;s/\"SRILM\nKENLM/\"SRILM KENLM\"/" ${mert_dir}/moses.ini> ${mert_dir}/moses-srilm.ini