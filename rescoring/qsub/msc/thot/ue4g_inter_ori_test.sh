#!/bin/bash
#$ -l h_rt=34:00:00 

#General parameters                                                                                                                           
rescorer=/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring_groundhog_test_interp_from_ori
objective_function=/home/lvapeab/smt/software/scripts/calcBleu.sh




nndir=/home/lvapeab/ueBLM_sdir_maximize_bleu_14810
lambda="0.6"

name="Ue4_test_inter${order}_lambda_${lambda}"

#Task dependant parameters                                                                                                                   

base_dir=/home/lvapeab/smt/tasks/ue/esen
test=${base_dir}/DATA/test.tok.dec.en
output=${base_dir}/THOT/EXPER/4gram/bidir_interp_test

wgdir=/home/lvapeab/smt/tasks/ue/esen/EXPER/4gram-dec/test/thot_dhs_min_2344/nbl





echo "Model: $bLM"
echo "Name: $name"
echo "OOV ratio: $oov"
echo "Order: $order"
echo "Interpolation weight: $lambda"

$rescorer -tdir /home/lvapeab -u $objective_function -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "0.562802 0.053972 0.695619 0.296632 0.165661 0.329336 0.11214 0.559003" -bdir $base_dir -sdir /home/lvapeab -wgdir $wgdir  -o $output -v -debug -name $name -nndir $nndir  -lambda $lambda -test $test