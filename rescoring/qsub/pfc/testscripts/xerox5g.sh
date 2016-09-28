#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu_nonneg.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.60629 0.129411 0.404852 0.00435145 0.177819 0.610711 0.326391 0.382774" -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 80 -qs "-l h_vmem=4g,h_rt=24:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/THOT/tuned/EXPER/5gram/test/thot_dhs_min_31851/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/5gram/test_interpolated_result -v -debug -name "Xerox-5test" -rnnlm /home/lvapeab/RNNLMs/lm-n600c200bp7bl.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/training.es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/test.es -lambda 0.5 -order "5"