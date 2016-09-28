#$ -l h_vmem=10g,h_rt=134:00:00
#$ -pe mp 6
#$ -v OMP_NUM_THREADS=6
export OMP_NUM_THREADS=6

export SCRIPTS_ROOTDIR=/home/lvapeab/smt/software/moses-git/scripts


/home/lvapeab/smt/software/moses-git/scripts/training/train-model.perl \
-external-bin-dir /home/lvapeab/smt/software/moses-git/bin/training-tools \
-mgiza -mgiza-cpus 5 -cores 6 \
-parallel -sort-buffer-size 10G  \
-root-dir /home/lvapeab/smt/tasks/europarl/esen/MOSES \
-corpus /home/lvapeab/smt/tasks/europarl/esen/DATA/training -f es -e en -alignment grow-diag-final-and -reordering msd-bidirectional-fe \
-lm 0:5:/home/lvapeab/smt/tasks/europarl/esen/LM/5gram.en