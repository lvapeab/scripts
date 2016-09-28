#!/bin/bash

#$ -l h_rt=144:00:00
#$ -l h_vmem=16g


/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0  -iv "2.27533 0.161063 2.85762 0.0190492 0.135242 1.3182 0.61156 2.82671" -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 40 -qs "-l h_vmem=16g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/5gram/test_results/thot_dhs_min_17882/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/5gram/test_result -v -debug -name "E5I" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt5.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2013.tc.es -lambda 0.7 -order "5"