#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.38192 0.841802 0.663812 0.380858 0.0696902 0.428348 0.491184 0.327773" -bdir /home/lvapeab/smt/tasks/turista -pr 40 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/5gram/test_results/thot_dhs_min_20339/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/5gram/test_results -v -debug -name "Turista9test" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt9.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "5"