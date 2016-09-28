#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.15525 0.508861 0.636314 0.0363689 0.309985 0.23386 0.274385 0.9982"  -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/2gram/test_results/thot_dhs_min_13157/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/2gram/test_results -v -debug -name "T2rnnt" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt2.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "2"