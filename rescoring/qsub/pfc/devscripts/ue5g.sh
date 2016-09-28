#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/ue/esen -pr 140 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/ue/esen/EXPER/5gram/dev/thot_dhs_min_30123/nbl   -o /home/lvapeab/smt/tasks/ue/esen/EXPER/5gram/interp -v -debug -name "UE-5" -rnnlm /home/lvapeab/RNNLMs/ue/lm-n310c150bp7bl.mod -train /home/lvapeab/smt/tasks/ue/esen/DATA/training.en -test /home/lvapeab/smt/tasks/ue/esen/DATA/dev.en -lambda 0.3 -order "5"