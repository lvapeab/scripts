#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.74845 1.33007 0.145281 0.022929 0.0496455 0.352572 0.0137682 0.398504" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 20 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/4gram/test_results/thot_dhs_min_21759/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/4gram/rnnlm_result_test -v -debug -name "X4rnnt" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps4.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "4"