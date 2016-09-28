#!/bin/bash
#$ -l h_vmem=2g
#$ -l h_rt=144:00:00 



export PYTHONPATH=/home/lvapeab/smt/software/rnnlib/utils:/home/lvapeab/bin:/home/lvapeab/smt/software/loopy/loopy/bin:/home/apps/ompi/1.6.4/gnu/bin:/bin:/usr/bin:/home/apps/oge/bin/linux-x64:/home/lvapeab/bin:/home/lvapeab/bin:/home/lvapeab/smt/software/loopy/bin:/home/lvapeab/loopy/bin:/home/apps/ompi/1.6.4/gnu/bin:/bin:/usr/bin:/home/apps/oge/bin/linux-x64:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/lvapeab/bin:.:${PYTHONPATH}

export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/mkl/lib/intel64/:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:${LD_LIBRARY_PATH}


export PATH=/home/lvapeab/smt/software/loopy/loopy/bin:/home/lvapeab/bin:/home/lvapeab/smt/software/loopy/loopy/bin:/home/apps/ompi/1.6.4/gnu/bin:/bin:/usr/bin:/home/apps/oge/bin/linux-x64:/home/lvapeab/bin:/home/lvapeab/bin:/home/lvapeab/smt/software/loopy/bin:/home/lvapeab/loopy/bin:/home/apps/ompi/1.6.4/gnu/bin:/bin:/usr/bin:/home/apps/oge/bin/linux-x64:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/lvapeab/bin:/home/lvapeab/smt/software/loopy/loopy/bin:/usr/lib64:${PATH}



export CPATH=/usr/lib64:${CPATH}
 
export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64"
/home/lvapeab/smt/software/loopy/loopy/bin/python /home/lvapeab/theano_tutorial/code/convolutional_network.py