#!/bin/bash

bpe_dir=/home/lvapeab/smt/software/subword-nmt

if [ $# -lt 3 ]; then
    echo "Usage: `basename $0` corpus_path l1 l2 <n_ops>"
    echo "Applies BPE to a corpus. The files must be named training.l?, dev.l?, test.l?"
    echo "example:`basename $0` europarl en fr 32000"
    exit 1
fi


corpus_path=$1
l1=$2
l2=$3

if [[ $# -lt 4 ]]
then
    n_ops=32000

else
    n_ops=$4
fi

# Prepare output dir
dest_dir=${corpus_path}/${l1}${l2}/bpe
mkdir -p ${dest_dir}

# Get BPE codes
for lang in $l1 $l2 ; do
    echo "Learning BPE for ${lang}..."
    ${bpe_dir}/learn_bpe.py -s ${n_ops} < ${corpus_path}/training.${lang} > ${dest_dir}/training_codes.${lang}
done

# Apply BPE codes (only for training and dev/test sources)

for lang in $l1 $l2 ; do
    echo "Applying BPE to training sets..."
    ${bpe_dir}/apply_bpe.py -c  ${dest_dir}/training_codes.${lang} > ${dest_dir}/training.${lang}
done


echo "Applying BPE to dev and test sets..."
${bpe_dir}/apply_bpe.py -c  ${dest_dir}/training_codes.${l1} > ${dest_dir}/dev.${l1}
${bpe_dir}/apply_bpe.py -c  ${dest_dir}/training_codes.${l1} > ${dest_dir}/test.${l1}

cat ${corpus_path}/dev.${l2} > ${dest_dir}/dev.${l2}
cat ${corpus_path}/test.${l2} > ${dest_dir}/test.${l2}
echo "Done"



