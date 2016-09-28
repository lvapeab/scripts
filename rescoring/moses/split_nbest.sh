#!/bin/bash

usage(){
    echo "Splits an nbest list of m sentences in m files."
    echo "Usage: split_nbest.sh nbest_file output_prefix"
}
                                                                                                                                         
# fragment the input                                                                                     
nbest=$1
output=$2

cat ${nbest} | awk -v out=${output} '{print $0 >> out"_"$1".nbl"}'
