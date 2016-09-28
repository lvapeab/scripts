#!/bin/bash

#$ -l h_rt=144:00:00 

/home/lvapeab/smt/software/scripts/nbl_rescoring_cslm -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/xerox -pr 20 -qs "-l h_vmem=4g,h_rt=144:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/xerox/enes/EXPER/3gram/adjw/thot_dhs_min_17188/nbl -o /home/lvapeab/smt/tasks/xerox/enes/EXPER/3gram/CSLM_result -v -debug -name "Xerox3CSLM" -cslm /home/lvapeab/CSLM/xerox/model3n.best.mach  -test /home/lvapeab/smt/tasks/xerox/enes/DATA/Es-dev -vocab /home/lvapeab/CSLM/xerox/data.cslm/Es-tr.wlall.wlist -srilm /home/lvapeab/CSLM/xerox/lm/all_ipol.3g.kn-int.arpa.gz 