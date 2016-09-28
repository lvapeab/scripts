#!/bin/bash
#$ -l h_rt=120:00:00
#$ -l h_vmem=64g

/home/lvapeab/smt/software/thot_git/bin/thot_tm_train -pr 140 -s /home/lvapeab/smt/tasks/europarl/esen/DATA/training.en -t /home/lvapeab/smt/tasks/europarl/esen/DATA/training.es \
-o /home/lvapeab/smt/tasks/europarl/esen/THOT/TM/esen2/ -qs "-l  h_rt=1:00:00 -l h_vmem=4g" -tdir /home/lvapeab -sdir /home/lvapeab -unk