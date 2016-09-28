#!/bin/bash

#$ -l h_rt=144:00:00 

/home/lvapeab/TURISTA/nbl_rescoring_cslm -tdir /home/lvapeab/ -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/turista -pr 4 -qs "-l h_vmem=1g,h_rt=4:00:00" -sdir /home/lvapeab/ -wgdir /home/lvapeab/smt/tasks/turista/EXPER/3gram/adjw/thot_dhs_min_17350/nbl -o /home/lvapeab/TURISTA/pruebas/cslm_result -v -debug -name "turista3cslm" -cslm /home/lvapeab/TURISTA/simple_model.mach -train /home/lvapeab/smt/tasks/turista/DATA/e-train -test /home/lvapeab/smt/tasks/turista/DATA/e-dev -lambda 0.7 -vocab /home/lvapeab/TURISTA/data.cslm/e-tr.wlall.wlist -srilm /home/lvapeab/TURISTA/lm/all_ipol.4g.kn-int.arpa.gz 
