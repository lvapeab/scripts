#!/bin/bash

processing_inmt_script=process_inmt_file.sh
ic_script=/home/lvapeab/smt/software/confidence_intervals/imt_confidence_intervals.sh

if [ $# -lt 1 ]
then
    echo "Usage: $0 text_file"
    echo "Processes an inmt log (NMT-Keras) and computes its WSR and MAR confidence intervals by bootstrap resampling"
    exit 1
fi

for file in  $* ;do
    destdir=`dirname $file`
    base=`basename $file`
    basename="${base%.*}"
    cp $file /tmp/$base
    ${processing_inmt_script} /tmp/$base
    n=`wc -l /tmp/$basename.scores|awk '{print $1}'`
    ${ic_script} -t /tmp/$basename.scores -n $n
done
