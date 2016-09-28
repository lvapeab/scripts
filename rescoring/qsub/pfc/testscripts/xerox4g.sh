#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_test_wb -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.97005 0.811414 0.659449 0.0485691 0.286605 1.01371 0.413801 0.301541" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 20 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/4gram/test_results/thot_dhs_min_21759/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/4gram/interpolated_result_test -v -debug -name "Xerox-4nwb_test" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps4.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-test -lambda 0.3175 -order "4"