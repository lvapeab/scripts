#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.546343 1.08721 0.160606 0.00904995 0.185567 0.392613 0.0143743 0.147313"-bdir /home/lvapeab/smt/tasks/xerox/enes -pr 30 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/5gram/test_results/thot_dhs_min_1859/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/5gram/test_rnnlm_result -v -debug -name "X5rnnt" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps5.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "5"