#!/bin/bash

#$ -l h_rt=144:00:00 
export THEANO_FLAGS=device=cpu,floatX=float32,gcc.cxxflags="-L /usr/lib64"
export PYTHONPATH=/home/lvapeab/smt/software/loopy/loopy/bin:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:/home/lvapeab/libexec/gcc/x86_64-unknown-linux-gnu/4.9.1/:${LD_LIBRARY_PATH}
export PATH=/home/lvapeab/smt/software/loopy/loopy/bin:/home/lvapeab/bin:/home/apps/oge/bin/linux-x64:${PATH}
export CPATH=/usr/lib64:${CPATH}

#General parameters
rescorer=/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring_groundhog
objective_function=/home/lvapeab/smt/software/scripts/calcBleu.sh
test_script=/home/lvapeab/smt/software/scripts/bLM/testModel.sh



bLM="/home/lvapeab/smt/software/myGroundHog/tutorials/LM/400_620state.pkl"
#bLM="/home/lvapeab/smt/software/myGroundHog/tutorials/LM/miniUE1soft/en_infreq150s_620dstate.pkl"

name="UE"
pr="60"
lambda=1


#Task dependant parameters
base_dir=/home/lvapeab/smt/tasks/ue/esen
wgdir=${base_dir}/EXPER/4gram-dec/thot_dhs_min_1516/nbl
output=${base_dir}/EXPER/4gram-dec/bidir_result
test_file=${base_dir}/DATA/dev.tok.dec.en

mkdir -p $output

echo "Model: $bLM"
echo "Name: $name"
echo "OOV ratio: $oov"
echo "Order: $order"
echo "Interpolation weight: $lambda"

$rescorer -tdir /home/lvapeab -u $objective_function -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir $base_dir -pr $pr -qs "-l h_vmem=4g,h_rt=60:00:00" -sdir /home/lvapeab -wgdir $wgdir  -o $output -v -debug -name $name -bLM $bLM -test_script $test_script  -test $test_file