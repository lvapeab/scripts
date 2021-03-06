#!/bin/bash

#$ -l h_rt=144:00:00 
                                                                                                                          
#$ -l h_vmem=16g                

/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.905799 0.0462047 0.638749 0.00985529 0.0878977 0.649522 0.141678 0.737842" -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 40 -qs "-l h_vmem=16g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/4gram/test_results/thot_dhs_min_20056/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/4gram/test_result -v -debug -name "E420test" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt20.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2013.tc.es -lambda 0.7 -order "4"