#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.1003 0.482915 0.251632 0.314832 0.108102 0.127943 0.208074 0.376417"  -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/2gram/test_results/thot_dhs_min_13157/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/2gram/test_results -v -debug -name "Turista2gtest" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt2.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "2"