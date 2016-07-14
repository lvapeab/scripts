#$ -l h_vmem=8g,h_rt=134:00:00

export SCRIPTS_ROOTDIR=/home/alvaro/smt/software/moses-git/scripts
/home/alvaro/smt/software/moses-git/scripts/training/train-model.perl \
-external-bin-dir /home/alvaro/smt/software/moses-git/bin/training-tools \
-mgiza \
-root-dir /home/alvaro/smt/tasks/xerox/enes/MOSES \
-corpus /home/alvaro/smt/tasks/xerox/enes/DATA/training -f en -e es -alignment grow-diag-final-and -reordering msd-bidirectional-fe \
-lm 0:4:/home/alvaro/smt/tasks/xerox/enes/LM/4gram/srilm/4gram