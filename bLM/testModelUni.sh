#!/bin/bash


export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64",exception_verbosity='high',openmp=True
python /home/lvapeab/smt/software/scripts/bLM/testModelUni.py $1 $2 