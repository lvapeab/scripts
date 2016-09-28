#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.368619 1.02199 0.287744 0.0139103 0.212793 0.548904 0.0734104 0.605357" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 30 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/3gram/test_results/thot_dhs_min_27839/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/3gram/rnnlm_result_test -v -debug -name "X3rnnt" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps3.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "3"