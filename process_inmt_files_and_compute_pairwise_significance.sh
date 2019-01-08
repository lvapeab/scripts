#!/bin/bash

processing_inmt_script=process_inmt_file.sh
ic_script=/home/lvapeab/smt/software/confidence_intervals/imt_confidence_intervals.sh

if [ $# -lt 2 ]
then
    echo -e "Usage: $0  -t file.imt [-b baseline.imt] [-n number_of_randomization] [-i interval]"
    echo -e "Processes two inmt logs (NMT-Keras) and computes its KSMR confidence intervals by bootstrap resampling and their statistical significance via approximate randomization test."
    echo -e "Options: "

    echo -e "\t -t file.imt: INMT log for computing KSMR CI."
    echo -e "\t -b baseline.imt: Basline INMT log. If specified, compute pairwise significance and confidence intervals.."   
    echo -e "\t -n number_of_randomization: Number of repetitions of the test. By default, 10,000"
    echo -e "\t -i interval: Confidence interval for bootstrap resampling. By default, 95."

    exit 1
fi
n=10000
interval="95"

while [ $# -ne 0 ]; do
    case $1 in

        "-t") shift
                 if [ $# -ne 0 ]; then
                     file1=$1
                 fi
                 ;;
        "-b") shift
                 if [ $# -ne 0 ]; then
                     baseline=$1
		 fi
                 ;;

	
        "-n") shift
                 if [ $# -ne 0 ]; then
                     n=$1
                 else
                     n=10000
                 fi
                 ;;
        "-i") shift
                 if [ $# -ne 0 ]; then
                     interval=$1
                 else
                     interval="95"
                 fi
                 ;;
    esac
    shift
done


tmpdir=$(mktemp -d /tmp/conftmp.XXXXXXXXXXX)

# Process file 1
base1=`basename ${file1}`
basename1="${base1%.*}"
cp ${file1} ${tmpdir}/${base1}
${processing_inmt_script} ${tmpdir}/$base1

# Process file 2                                                                                                                                                          
baseline=`basename ${baseline}`
baselinename="${baseline%.*}"
cp ${baseline} ${tmpdir}/${baseline}
${processing_inmt_script} ${tmpdir}/$baseline


# Hypothesis testing
${ic_script} -t ${tmpdir}/${basename1}.scores -b ${tmpdir}/${baselinename}.scores -n ${n} -i ${interval} 
