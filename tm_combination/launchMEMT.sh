#!/bin/bash


usage(){
    echo "Usage: /launchMEMT.sh <matched_file> <lm> [decoder_config_name] "
    echo " matched file        : Matched file with all M systems to be combined."
    echo " lm                  : Task LM in ARPA format."
    echo " decoder_config_name : Name of the config file of the decoder. It is expected to be in the same folder than the matched file (decoder_config_base by default. "
    echo " DO NOT FORGET TO KILL THE MEMT SERVER AT THE END OF THE EXPERIMENT!!"  
}




if [ $# -eq 0 ]; then
    usage
    exit 0;
fi



memt_dir=/home/alvaro/smt/software/memt
matched_file=$1
lm=$2
task_dir=`dirname ${matched_file}`
decoder_config=${task_dir}/decoder_config_base

if [ $# -eq 3 ]; then
    decoder_config=${task_dir}/$3
fi


echo "Launching MERT"
${memt_dir}/MEMT/scripts/zmert/run.rb ${task_dir} 2000 En
echo "DON'T FORGET TO KILL THE MEMT SERVER!!"
#kill -9 `ps -A |grep MEMT |awk '{print $1}'`