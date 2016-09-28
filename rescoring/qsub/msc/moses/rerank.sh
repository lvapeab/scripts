#!/bin/bash

#$ -l h_rt=10:00:00 
#$ -l h_vmem=4g
#General parameters
reranker=/home/lvapeab/smt/software/scripts/rescoring/moses/qs_rerank.sh
splitter=/home/lvapeab/smt/software/scripts/rescoring/moses/split_nbest.sh
name="moses100_test"
pr="20"

#Task dependant parameters
weights=/home/lvapeab/smt/tasks/ue/esen/MOSES/model/mert2/run5.weights.txt
tdir=/home/lvapeab/UE5_100_rescoring
nbest=${tdir}/UE5_100.nbl
nb_dir=${tdir}/split
output=${tdir}/rescored


mkdir -p $nb_dir
echo "Name: $name"






echo "Splitting nbest list"

$splitter $nbest $nb_dir/$name

echo "List split"

echo "Reranking"

$reranker -tdir ${tdir}  -nbdir $nb_dir -weights ${weights} -pr $pr -qs "-l h_vmem=4g,h_rt=4:00:00" -sdir ${tdir}  -o $output -v -debug -name $name