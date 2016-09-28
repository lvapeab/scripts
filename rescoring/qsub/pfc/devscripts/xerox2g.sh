#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/ue/esen -pr 40 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir   -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/2gram/interpolated_rnnlm_result -v -debug -name "Xerox-2nwb" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps2.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-dev -lambda 0.3175 -order "2"