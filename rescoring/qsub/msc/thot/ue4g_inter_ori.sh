#!/bin/bash
#$ -l h_rt=34:00:00 

#General parameters                                                                                                                           
rescorer=/home/lvapeab/smt/software/scripts/rescoring/nbl_interpolation
objective_function=/home/lvapeab/smt/software/scripts/calcBleu.sh




nndir=/home/lvapeab/UE_sdir_maximize_bleu_22615
lambda="0.9"

name="Ue4_inter${order}_lambda_${lambda}"

#Task dependant parameters                                                                                                                   

base_dir=/home/lvapeab/smt/tasks/ue/esen
test=${base_dir}/DATA/dev.tok.dec.en
output=${base_dir}/THOT/EXPER/4gram/bidir_interp


wgdir=/home/lvapeab/smt/tasks/ue/esen/EXPER/4gram-dec/thot_dhs_min_1516/nbl





echo "Model: $bLM"
echo "Name: $name"
echo "OOV ratio: $oov"
echo "Order: $order"
echo "Interpolation weight: $lambda"

$rescorer -tdir /home/lvapeab -u $objective_function -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir $base_dir -sdir /home/lvapeab -wgdir $wgdir  -o $output -v -debug -name $name -nndir $nndir  -lambda $lambda -test $test