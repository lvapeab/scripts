#!/bin/bash

memt_dir=/home/alvaro/smt/software/memt
matched_file=$1
lm=$2
task_dir=`dirname ${matched_file}`
decoder_config=${task_dir}/decoder_config

#Launch server
#echo "Launching server"
#${memt_dir}MEMT/scripts/server.sh --lm.file ${lm} --port 2000 &


echo "Decoding"
${memt_dir}/MEMT/scripts/simple_decode.rb 2000 ${decoder_config} ${matched_file}