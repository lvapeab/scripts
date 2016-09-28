#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/5gram/adjw/thot_dhs_min_30702/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/5gram/interpolated_result2 -v -debug -name "Turista9" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt9.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-dev -lambda 0.7 -order "5"