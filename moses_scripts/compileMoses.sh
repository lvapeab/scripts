#!/bin/bash

#$ -pe mpi 8 
#$ -l h_vmem=4g,h_rt=100:30:00

/home/lvapeab/smt/software/moses/bjam  -j 8 --with-srilm=/home/lvapeab/smt/software/srilm --with-boost=/home/lvapeab/smt/software/boost_1_55_0 --prefix=/home/lvapeab/smt/software/moses --with-oxlm=/home/lvapeab/smt/software/OxLM


