#!/bin/bash

#$ -l h_rt=144:00:00 

bLM="/home/lvapeab/smt/software/myGroundHog/tutorials/LM/miniueUni/en_120_620state.pkl"
name="UE_uni_400"
pr="40"

wgdir=/home/lvapeab/smt/tasks/ue/esen/REDUCED/EXPER/tuning/4gram/thot_dhs_min_2549/nbl
lambda=1


echo "Model: $bLM"
echo "Name: $name"
echo "Interpolation weight: $lambda"




/home/lvapeab/smt/software/scripts/nbl_rescoring_groundhog -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -bdir /home/lvapeab/smt/tasks/ue/esen -pr $pr -qs "-l h_vmem=4g,h_rt=60:00:00" -sdir /home/lvapeab -wgdir $wgdir  -o /home/lvapeab/smt/tasks/ue/esen/THOT/EXPER/4gram/bidir_result1 -v -debug -name $name -bLM $bLM -test_script /home/lvapeab/smt/software/scripts/bLM/testModelUni.sh -train /home/lvapeab/smt/tasks/ue/esen/DATA/reduced/en -test /home/lvapeab/smt/tasks/ue/esen/DATA/test.tok.en -oov $oov -order $order