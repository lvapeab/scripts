#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.00253 0.309544 0.301728 0.301129 0.298378 0.306479 0.299404 0.303303" -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/3gram/test_results/thot_dhs_min_16653/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/3gram/test_results -v -debug -name "T3rnnt" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt3.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "3"