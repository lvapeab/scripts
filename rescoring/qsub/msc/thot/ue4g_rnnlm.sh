#!/bin/bash

#$ -l h_rt=144:00:00 


/home/lvapeab/smt/software/scripts/nbl_rescoring_no_interpolation -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/ue/esen -pr 40 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/ue/esen/REDUCED/EXPER/tuning/4gram/thot_dhs_min_2549/nbl -o /home/lvapeab -v -debug -name "Ue-4rnnlm" -rnnlm /home/lvapeab/RNNLMs/lm-n240c200bp7bl.mod  -train /home/lvapeab/smt/tasks/ue/esen/DATA/reduced/en -test /home/lvapeab/smt/tasks/ue/esen/DATA/test.tok.en