#!/bin/bash

#$ -l h_rt=34:00:00 

#General parameters                                                                                                                           
rescorer=/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring_groundhog_inter_from_rescored
objective_function=/home/lvapeab/smt/software/scripts/calcBleu.sh
test_script=/home/lvapeab/smt/software/scripts/bLM/testModel.sh

bLM="/home/lvapeab/smt/software/myGroundHog/tutorials/LM/400_620state.pkl"
lambda=0.1
order=4
name="Ue4_inter${order}_lambda_${lambda}"
pr="10"
qs="-l h_vmem=4g,h_rt=60:00:00"

#Task dependant parameters                                                                                                                    


base_dir=/home/lvapeab/smt/tasks/ue/esen
train_data=${base_dir}/DATA/training.sel.en
test_data=${base_dir}/DATA/dev.tok.dec.en
output=${base_dir}/THOT/EXPER/4gram/bidir_interp2


wgdir=/home/lvapeab/UE_sdir_maximize_bleu_22615





echo "Model: $bLM"
echo "Name: $name"
echo "OOV ratio: $oov"
echo "Order: $order"
echo "Interpolation weight: $lambda"

$rescorer -tdir /home/lvapeab -u $objective_function -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir $base_dir -pr $pr -qs $qs -sdir /home/lvapeab -wgdir $wgdir  -o $output -v -debug -name $name -bLM $bLM -test_script  $test_script -train $train_data -test $test_data -order $order -lambda $lambda