#!/bin/bash

GIZA=/home/lvapeab/smt/software/mgiza/mgizapp/bin



if [ $# -ne 3 ];then
    echo "Usage: align_corpora.sh <file.en> <file.es> <dest_dir>"
    exit 0
fi




prefix=$3

mkdir -p $prefix
text_1=$1 
text_2=$2

name_1=`basename ${text_1}`
name_2=`basename ${text_2}`

echo "Obtaining target and source vocabulary files (.vcb) and sentence pair file (.snt)."
${GIZA}/plain2snt ${text_1} ${text_2} -snt1  ${prefix}/${name_1}_${name_2}.snt -snt2  ${prefix}/${name_2}_${name_1}.snt -vcb1  ${prefix}/${name_1}.vcb -vcb2  ${prefix}/${name_2}.vcb
echo "Done"
echo "Creating coocurrence file"
${GIZA}/snt2cooc   ${prefix}/${name_1}_${name_2}.cooc  ${prefix}/${name_1}.vcb  ${prefix}/${name_2}.vcb  ${prefix}/${name_1}_${name_2}.snt
${GIZA}/snt2cooc   ${prefix}/${name_2}_${name_1}.cooc  ${prefix}/${name_2}.vcb  ${prefix}/${name_1}.vcb  ${prefix}/${name_2}_${name_1}.snt

echo "Aligning with GIZA++"
echo "One way (${name_1} -> ${name_2})"
${GIZA}/mgiza -s ${prefix}/${name_1}.vcb -t  ${prefix}/${name_2}.vcb -c  ${prefix}/${name_1}_${name_2}.snt -coocurrencefile  ${prefix}/${name_1}_${name_2}.cooc -o ${prefix}/${name_1}_${name_2}

echo "And the other (${name_2} -> ${name_1})"
${GIZA}/mgiza -s   ${prefix}/${name_2}.vcb -t ${prefix}/${name_1}.vcb -c  ${prefix}/${name_2}_${name_1}.snt -coocurrencefile  ${prefix}/${name_2}_${name_1}.cooc -o ${prefix}/${name_2}_${name_1}

echo "Done"
