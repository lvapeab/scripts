#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 80 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/THOT/tuned/EXPER/5gram/thot_dhs_min_8370/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/THOT/tuned/EXPER/5gram/interp -v -debug -name "Xerox-5" -rnnlm /home/lvapeab/RNNLMs/lm-n600c200bp7bl.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/training.es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/dev.es -lambda 0.5 -order "5"