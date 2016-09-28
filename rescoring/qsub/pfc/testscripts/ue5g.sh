#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "2.26536 0.378415 0.831706 0.548049 0.359575 0.941352 0.833341 1.02228" -bdir /home/lvapeab/smt/tasks/ue/esen -pr 150 -qs "-l h_vmem=4g,h_rt=2:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/ue/esen/EXPER/5gram/test/thot_dhs_min_21173/nbl  -o /home/lvapeab/smt/tasks/ue/esen/EXPER/5gram/test_rnn -v -debug -name "UE-5test" -rnnlm /home/lvapeab/RNNLMs/ue/lm-n310c150bp7bl.mod -train /home/lvapeab/smt/tasks/ue/esen/DATA/training.en -test /home/lvapeab/smt/tasks/ue/esen/DATA/test.en -lambda 0.3 -order "5"
