#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 30 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/europarl/enes/EXPER/2gram/adjw/thot_dhs_min_32436/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/2gram/rnnlm_result -v -debug -name "europarl2rnnlm" -rnnlm /home/lvapeab/RNNLMs/Europarl/lm-n400c400bptt2.mod -train /home/lvapeab/smt/tasks/europarl/enes/DATA/europarl.truecased.1.es.cleaned.trunc40 -test /home/lvapeab/smt/tasks/europarl/enes/DATA/newstest2012.tc.es -lambda 0.7 -order "2"