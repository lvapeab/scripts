#$ -pe mpi 2
#$ -l h_vmem=4g,h_rt=24:00:00




DATA=/home/lvapeab/smt/tasks/ue/esen/DATA
model=/home/lvapeab/smt/tasks/ue/esen/MOSES/model/mert-work_n2500/moses.ini
mert_dir=/home/lvapeab/smt/tasks/ue/esen/MOSES/model/mert-work_n2500


/home/lvapeab/smt/software/moses-git/scripts/training/mert-moses.pl ${DATA}/dev.es ${DATA}/dev.en  \
/home/lvapeab/smt/software/moses-git/bin/moses ${model} \
--mertdir /home/lvapeab/smt/software/moses-git/bin \
--rootdir /home/lvapeab/smt/software/moses-git/scripts \
--working-dir=${mert_dir} \
--decoder-flags "-threads 2 -feature-name-overwrite \"SRILM KENLM\"" \
--maximum-iterations=8 \
--nbest=2500 \
--continue \
--skip-decoder 


sed ":a;N;$bash;s/\"SRILM\nKENLM/\"SRILM KENLM\"/" ${mert_dir}/moses.ini> ${mert_dir}/moses-srilm.ini