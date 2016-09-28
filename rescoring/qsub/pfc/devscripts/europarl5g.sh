#!/bin/bash

#$ -l h_rt=144:00:00
#$ -l h_vmem=16g


/home/lvapeab/smt/software/scripts/nbl_rescoring -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/europarl/enes -pr 30 -qs "-l h_vmem=16g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/minieuroparl/THOT/EXPER/5gram/adjw/thot_dhs_min_14413/nbl -o /home/lvapeab/smt/tasks/europarl/enes/EXPER/5gram/interpolation_result -v -debug -name "europarl5g" -rnnlm /home/lvapeab/smt/tasks/minieuroparl/LM/rnnlm -train /home/lvapeab/smt/tasks/minieuroparl/DATA/training.clean.tok.es -test /home/lvapeab/smt/tasks/minieuroparl/DATA/dev.tok.es -lambda 0.6 -order "5"