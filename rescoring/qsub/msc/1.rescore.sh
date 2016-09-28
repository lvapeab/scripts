#!/bin/bash
#$ -l h_rt=40:00:00 
export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64"
export PYTHONPATH=/home/lvapeab/smt/software/loopy/loopy/bin:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:/home/lvapeab/libexec/gcc/x86_64-unknown-linux-gnu/4.9.1/:${LD_LIBRARY_PATH}
export PATH=/home/lvapeab/smt/software/loopy/loopy/bin:/home/lvapeab/bin:/home/apps/oge/bin/linux-x64:${PATH}
export CPATH=/usr/lib64:${CPATH}

#General parameters
rescorer=/home/lvapeab/smt/software/scripts/rescoring/moses/nbl_rescoring_rnnlm_moses_interp
rnnlm="/home/lvapeab/RNNLMs/ue/lm-n310c150bp7bl.mod"


name="ue_test"
pr="800"
lambda=0.5


#Task dependant parameters
base_dir=/home/lvapeab/
nblist=/home/lvapeab/ue_test/out.2500


tdir=/home/lvapeab/${name}
sdir=${tdir}


output=${tdir}/${name}_rescoring/rescored


mkdir -p $output

echo "Model: $rnnlm"
echo "Name: $name"

echo "Processors: $pr"

echo "Base dir: $base_dir"
echo "Temporal dir: $tdir"
echo "N-Best list: $nblist"
echo "Output prefix: $output"
echo "Output dir: $output"

echo "Rescoring nbest list..."
$rescorer -tdir $tdir  -bdir $base_dir -pr $pr -qs "-l h_vmem=4g,h_rt=5:00:00" -sdir $sdir -v -debug -name $name -rnnlm $rnnlm -nbest $nblist -o $output -lambda ${lambda}

echo "Ende"