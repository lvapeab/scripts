#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test_wb -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv  "0.539575 1.10963 0.0988063 0.0314395 0.088682 0.868732 0.0850473 0.280456" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 40 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/2gram/test_results/thot_dhs_min_21758/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/2gram/test_results/interpolated_results -v -debug -name "Xerox-2wbtest" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps2.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "2"