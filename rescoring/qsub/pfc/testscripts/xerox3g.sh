#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test_wb -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.41991 0.470485 0.373449 0.00537821 0.213208 0.956467 0.201131 0.782059" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 30 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/3gram/test_results/thot_dhs_min_27839/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/3gram/interpolated_result_test -v -debug -name "Xerox-3nwbtest" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps3.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "3"