#!/bin/bash

#$ -l h_rt=144:00:00                                                                                                            
#$ -l h_vmem=4g                
test_script=/home/lvapeab/smt/software/scripts/bLM/testModel.sh
base_dir=/home/lvapeab/smt/tasks/ue/esen
wgdir=${base_dir}/EXPER/4gram-dec/test/thot_dhs_min_2344/nbl
output=${base_dir}/EXPER/4gram-dec/bidir_result
test_file=${base_dir}/DATA/test.tok.dec.en


/home/lvapeab/smt/software/scripts/rescoring/nbl_rescoring_groundhog_test -tdir /home/lvapeab -u /home/lvapeab/smt/software/scripts/calcBleu.sh -va -0 -0 -0 -0 -0 -0 -0 -0 -iv "1.28959 0.562426 0.524773 0.287899 0.429754 0.42304 0.262017 0.317954" -bdir /home/lvapeab/smt/tasks/ue/esen -pr 40 -qs "-l h_vmem=4g,h_rt=44:00:00" -sdir /home/lvapeab -wgdir /home/lvapeab/smt/tasks/ue/esen/EXPER/4gram-dec/test/thot_dhs_min_2344/nbl -o /home/lvapeab/smt/tasks/ue/esen/EXPER/4gram-dec/test/groundhog -v -debug -name "ueBLM" -bLM /home/lvapeab/smt/software/myGroundHog/tutorials/LM/400_620state.pkl -test_script $test_script -test ${test_file}