#!/bin/bash

#$ -l h_rt=144:00:00

/home/lvapeab/smt/software/brown-cluster/wcluster --c 760 --threads=1 --text /home/lvapeab/smt/tasks/minieuroparl/DATA/oxlm/training.unk.es --output_dir=/home/lvapeab/smt/tasks/minieuroparl/DATA/oxlm/clusters