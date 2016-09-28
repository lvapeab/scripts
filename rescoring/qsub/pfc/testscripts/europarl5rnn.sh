#!/bin/bash

#$ -l h_rt=144:00:00
#$ -l h_vmem=16g


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0  -iv "1.59529 0.157988 3.31275 0.0513854 0.0844472 1.11639 0.107626 2.18419 " -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 80 -qs "-l h_vmem=16g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/5gram/test_results/thot_dhs_min_17882/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/5gram/test_result_rnnlm -v -debug -name "E5R" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt5.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2013.tc.es -lambda 0.7 -order "5"