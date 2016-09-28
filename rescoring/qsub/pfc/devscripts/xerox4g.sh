#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/xerox/enes -pr 40 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/4gram/adjw/thot_dhs_min_22259/nbl  -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/4gram/interpolated_result -v -debug -name "Xerox-4nwb" -rnnlm /home/lvapeab/RNNLMs/Xerox/lm-n400c200steps4.mod  -train /home/lvapeab/smt/tasks/xerox/enes/DATA/Es -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-dev -lambda 0.3175 -order "4"