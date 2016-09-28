#!/bin/bash

#$ -l h_rt=4:00:00

/home/lvapeab/smt/software/thot_git/bin/thot_prepare_sys_for_test -c /home/lvapeab/smt/tasks/europarl/esen/THOT/tuned/tuned_for_dev.cfg -t  /home/lvapeab/smt/tasks/europarl/esen/DATA/test.en -o /home/lvapeab/smt/tasks/europarl/esen/THOT/system4test -qs "-l h_vmem=4g,h_rt=1:00:00" -sdir /home/lvapeab/