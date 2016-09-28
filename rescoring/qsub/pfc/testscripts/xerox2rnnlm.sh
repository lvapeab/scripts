#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv  "0.842782 1.2175 0.555749 0.0293297 0.335485 0.813861 0.405011 0.177299" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 40 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/2gram/test_results/thot_dhs_min_21758/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/2gram/test_results/interpolated_results -v -debug -name "X2rnnt" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps2.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "2"