#!/bin/bash

#$ -l h_rt=144:00:00

/home/lvapeab/smt/software/thot_git/bin/thot_smt_tune -pr 140 -c /home/lvapeab/smt/tasks/europarl/esen/THOT/europarl.esen.cfg -s /home/lvapeab/smt/tasks/europarl/esen/DATA/dev.es -t /home/lvapeab/smt/tasks/europarl/esen/DATA/dev.en -o /home/lvapeab/smt/tasks/europarl/esen/THOT/tuned -qs "-l h_vmem=8g,h_rt=5:00:00" -sdir /home/lvapeab -tdir /home/lvapeab