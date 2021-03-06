#!/bin/bash

#$ -l h_rt=144:00:00 
                                                                                                                          
#$ -l h_vmem=16g                

/home/lvapeab/smt/software/scripts/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 40 -qs "-l h_vmem=16g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/4gram/adjw/thot_dhs_min_6219/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/4gram/interpolation_result -v -debug -name "europarl20n" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt20.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2012.tc.es -lambda 0.7 -order "4"