#!/bin/bash

#$ -l h_rt=40:00:00 
export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64"
export PYTHONPATH=/home/lvapeab/smt/software/loopy/loopy/bin:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:/home/lvapeab/libexec/gcc/x86_64-unknown-linux-gnu/4.9.1/:${LD_LIBRARY_PATH}
export PATH=/home/lvapeab/smt/software/loopy/loopy/bin:/home/lvapeab/bin:/home/apps/oge/bin/linux-x64:${PATH}
export CPATH=/usr/lib64:${CPATH}

#General parameters
rescorer=/home/lvapeab/smt/software/scripts/rescoring/moses/nbl_rescoring_rnnlmlm_moses_interp
# test_script=/home/lvapeab/smt/software/scripts/rnnlm/testModel2.sh
reranker=/home/lvapeab/smt/software/scripts/rescoring/moses/qs_rerank.sh
splitter=/home/lvapeab/smt/software/scripts/rescoring/moses/split_nbest.sh

rnnlm="/home/lvapeab/RNNLMLMs/lm-n600c200bp7bl.mod"


name="Xerox_5g"
pr="80"
lambda=0.5


#Task dependant parameters
base_dir=/home/lvapeab/
nblist=/home/lvapeab/xerox_moses/run4.best2500.out
output=${base_dir}/bidir_result

tdir=/home/lvapeab/${name}
sdir=${tdir}
weights=/home/lvapeab/smt/tasks/xerox/enes/MOSES/mert-work_n2500/run4.weights.txt
nbest=${tdir}/${name}_rescoring/${name}.nbl
nb_dir=${tdir}/${name}_rescoring/split
output=${tdir}/${name}_rescoring/rescored


mkdir -p $output
mkdir -p $nb_dir

echo "Model: $rnnlm"
echo "Name: $name"

echo "Processors: $pr"

echo "Base dir: $base_dir"
echo "Temporal dir: $tdir"
echo "N-Best list: $nblist"
echo "Output prefix: $output"
echo "Weights: $weights"
echo "Rescored nbest: $nbest"
echo "Rescoring dir: $nb_dir"
echo "Output dir: $output"


echo "Rescoring nbest list"

$rescorer -tdir $tdir  -bdir $base_dir -pr $pr -qs "-l h_vmem=4g,h_rt=5:00:00" -sdir $sdir -v -debug -name $name -rnnlm $rnnlm -nbest $nblist -o $output