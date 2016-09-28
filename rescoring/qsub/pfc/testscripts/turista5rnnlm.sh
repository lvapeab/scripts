#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.988964 1.06581 0.44399 0.239683 0.0353694 0.468069 0.630669 0.486153" -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/5gram/test_results/thot_dhs_min_20339/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/5gram/test_results -v -debug -name "T5rnnt" -rnnlm  /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt5.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "5"