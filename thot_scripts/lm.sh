#!/bin/bash

#$ -l h_rt=5:00:00

/home/lvapeab/smt/software/thot_git/bin/thot_lm_train -pr 40 -c /home/lvapeab/smt/tasks/europarl/esen/DATA/training.en -o /home/lvapeab/smt/tasks/europarl/esen/THOT/LM -n 5 -unk -ps "-l  h_rt=3:00:00" -tdir /home/lvapeab/dump -sdir /home/lvapeab/dump