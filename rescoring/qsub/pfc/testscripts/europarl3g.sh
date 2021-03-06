#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.731636 0.0704258 1.17665 0.0139028 0.00440876 0.557106 0.0479121 1.43272" -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 30 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/3gram/test_results/thot_dhs_min_6873/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/3gram/interp_result_test -v -debug -name "E3I" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt3.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2013.tc.es -lambda 0.7 -order "3"