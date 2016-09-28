#!/bin/bash
#$ -l h_rt=10:00:00 
#$ -l h_vmem=4g
export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64"
export PYTHONPATH=/home/lvapeab/smt/software/loopy/loopy/bin:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:/home/lvapeab/libexec/gcc/x86_64-unknown-linux-gnu/4.9.1/:${LD_LIBRARY_PATH}
export PATH=/home/lvapeab/smt/software/loopy/loopy/bin:/home/lvapeab/bin:/home/apps/oge/bin/linux-x64:${PATH}
export CPATH=/usr/lib64:${CPATH}

#General parameters
reranker=/home/lvapeab/smt/software/scripts/rescoring/moses/qs_rerank.sh
splitter=/home/lvapeab/smt/software/scripts/rescoring/moses/split_nbest.sh

name="x"
pr="20"
lambda=0.7

tdir=/home/lvapeab/${name}
sdir=${tdir}
#Task dependant parameters
base_dir=${tdir}
nblist=${base_dir}/${name}_rescoring_15386/${name}.nbl
output=${base_dir}/result/${task}

weights=/home/lvapeab/smt/tasks/xerox/enes/MOSES/mert-work_n2500/weights.txt


nb_dir=${tdir}/${name}/split
output=${tdir}/${name}/rescored/out


mkdir -p $nb_dir
mkdir -p `dirname $output`

echo "Name: $name"
echo "Processors: $pr"

echo "Base dir: $base_dir"
echo "Temporal dir: $tdir"
echo "N-Best list: $nblist"
echo "Output prefix: $output"
echo "Weights: $weights"
echo "Rescoring dir: $nb_dir"
echo "Output dir: $output"

echo "Splitting nbest list"
$splitter $nblist $nb_dir/$name
echo "List split"

echo "Resorting list"
$reranker -tdir ${tdir}  -nbdir $nb_dir -weights ${weights} -pr $pr -qs "-l h_vmem=4g,h_rt=10:00:00" -sdir ${sdir}  -o $output -v -debug -name $name
echo "List resorted. Process ended."
