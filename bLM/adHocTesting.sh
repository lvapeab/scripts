#!/bin/bash

#$ -l h_vmem=4g

# $1: Data
# $2: Model

data=/home/lvapeab/test
model=/home/lvapeab/smt/software/myGroundHog/tutorials/LM/400_620state.pkl

export python=/home/lvapeab/smt/software/loopy/loopy/bin/python

export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64",exception_verbosity='high',openmp=True
$python /home/lvapeab/smt/software/scripts/bLM/testModel.py $model  $data