#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.19958 0.0163386 0.494734 0.533186 0.561291 0.563027 0.411672 1.44298" -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 30 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/2gram/test_results/thot_dhs_min_13034/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/2gram/inter_result_test -v -debug -name "E2I" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt2.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2013.tc.es -lambda 0.7 -order "2"