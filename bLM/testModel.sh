#!/bin/bash

export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L/home/lvapeab/lib64",exception_verbosity='high' #,openmp=True


export PYTHONPATH=/home/lvapeab/smt/software/loopy/loopy/bin:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:/home/lvapeab/libexec/gcc/x86_64-unknown-linux-gnu/4.9.1/:${LD_LIBRARY_PATH}
export PATH=/home/lvapeab/smt/software/loopy/loopy/bin:/home/lvapeab/bin:/home/apps/oge/bin/linux-x64:${PATH}
export CPATH=/usr/lib64:${CPATH}

python /home/lvapeab/smt/software/scripts/bLM/testModel.py $1 $2