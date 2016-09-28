#!/bin/bash
#$ -l h_vmem=62g
#$ -l h_rt=18:00:00  


cslm=/home/lvapeab/smt/software/cslm/cslm_v2.0/src


nbl=$1
dest=$2
weights=/home/lvapeab/smt/tasks/ue/esen/MOSES/model/mert-work/run5.weights.txt

$cslm/nbest -i $nbl -o $dest --sort --recalc --weights $weights 