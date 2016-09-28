#!/bin/bash

#$ -l h_rt=144:00:00 
                                                                                                                          
#$ -l h_vmem=16g                

/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.44066 0.235207 2.08836 0.0222251 0.0306137 1.01736 0.862035 1.21689" -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 40 -qs "-l h_vmem=16g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/4gram/test_results/thot_dhs_min_20056/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/4gram/test_result_rnn -v -debug -name "E4R" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt4.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2013.tc.es -lambda 0.7 -order "4"