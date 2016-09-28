#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.00788 0.323289 0.412901 0.255229 0.202506 0.337158 0.249696 0.0491069" -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/3gram/test_results/thot_dhs_min_16653/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/3gram/test_results -v -debug -name "Turista3test" -rnnlm /home/lvapeab/RNNLMs/Turista/lm-n50c200bptt3.mod -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-test -lambda 0.7 -order "3"