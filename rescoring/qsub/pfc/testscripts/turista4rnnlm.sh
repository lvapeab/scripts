#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.566986 0.59811 0.469797 0.480863 0.0521371 0.547567 0.634407 0.47753" -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/4gram/test_results/thot_dhs_min_30131/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/4gram/test_results -v -debug -name "T4rnnt" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt4.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "4"