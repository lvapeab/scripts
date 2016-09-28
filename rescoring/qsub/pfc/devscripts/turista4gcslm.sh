#!/bin/bash

#$ -l h_rt=144:00:00 
  

/home/lvapeab/smt/software/scripts/nbl_rescoring_cslm_2 -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/turista/EXPER/4gram/adjw/thot_dhs_min_6594/nbl -o /home/lvapeab/smt/tasks/turista/EXPER/4gram/LSTM_result -v -debug -name "Turista4CSLM" -cslm /home/lvapeab/TURISTA/model5.best.mach  -test /home/lvapeab/smt/tasks/turista/DATA/e-dev -vocab /home/lvapeab/TURISTA/data.cslm/e-tr.wlall.wlist -srilm /home/lvapeab/TURISTA/lm/all_ipol.4g.kn-int.arpa.gz -train  /home/lvapeab/smt/tasks/turista/DATA/e-train