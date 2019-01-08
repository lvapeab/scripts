#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: `basename $0` task source_language target_language [-a algorithm] [-l loss] [-p path] [-s split]"
    echo "Computes BLEU and sorts by BLEU the hypotheses."
    echo "example:`basename $0` europarl es  en SGD categorical_crossentropy OL/logs"
    echo "We assume that the calc_bleu tool is in $path and that the references are in ~/DATASETS/task/srctrg/split.trg"
    echo "Default values:"
    echo -e "\t algorithm: all (*)"
    echo -e "\t loss: all (*)"
    echo -e "\t path: ."
fi

task=$1
src=$2
trg=$3
algo="*"
loss="*"
path="."
split="dev"


while [ $# -ne 0 ]; do
    case $1 in
	"--help") usage
		  exit 0
		  ;;
	"-a") shift
	      algo=$1
	      ;;
	"-l") shift
	      loss=$1
	      ;;
	"-p") shift
	      path=$1
	      ;;
	"-s") shift
	      split=$1
	      ;;	
    esac
    shift
done


tmp=`mktemp -d`

for f in ${path}/${task}.${src}${trg}.${split}*.${algo}.*.${loss}.${trg} ; do
    echo "$f" >> ${tmp}/names
    calc_bleu -r ~/DATASETS/${task}/${src}${trg}/${split}.${trg} -t ${f} | awk '{print $1" "$2}' >> ${tmp}/bleus
    echo -n "."
done
echo ""

paste  ${tmp}/bleus ${tmp}/names | sort -nr -k 2
rm -rf ${tmp}
