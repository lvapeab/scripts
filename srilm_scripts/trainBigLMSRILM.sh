#/bin/bash 

#$ -l h_rt=44:00:00
#$ -l h_vmem=128g                                                                                                                       
 

export LD_LIBRARY_PATH=/home/lvapeab/smt/software/tcl/lib
srilmpath=/home/lvapeab/smt/software/srilm/bin/i686-m64

train=/home/lvapeab/smt/tasks/wmt15/DATA/training.fr
test=/home/lvapeab/smt/tasks/wmt15/DATA/test.fr
dest=/home/lvapeab/smt/tasks/wmt15/enfr/LM/5gram.fr


mkdir -p `dirname ${dest}`
order="5"


echo "Counting..."

$srilmpath/ngram-count -write `dirname ${dest}`/counts.gz -text ${train} -order ${order}

echo "Making big-lm"

${srilmpath}/../make-big-lm -read `dirname ${dest}`/counts.gz -order 5 -kndiscount -interpolate -unk -text ${train} -lm ${dest}

echo "Computing ppl"

${srilmpath}/ngram -lm $dest -order $order -ppl ${test} -unk

echo "Done :)"