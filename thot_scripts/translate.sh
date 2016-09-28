#!/bin/bash

#$ -l h_vmem=16g
#$ -l h_rt=24:00:00
thot_decoder=/home/lvapeab/smt/software/thot_git/bin/thot_decoder
src_test_corpus=/home/lvapeab/smt/tasks/europarl/esen/DATA/test.en
config_file=/home/lvapeab/smt/tasks/europarl/esen/THOT/system4test/test_specific.cfg
out=/home/lvapeab/europarl.test.hyp.es

${thot_decoder} -c ${config_file} -t ${src_test_corpus} -o ${out} -qs "-l h_vmem=12g" -pr 8
