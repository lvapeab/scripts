#!/bin/bash


if [ $# -ne 2 ]
then
    echo "Usage: $0 text_file1 text_file2"
    echo "Computes the vocabulary size of text_file1, text_file2"
    echo "and computes the union/intersection of those vocabularies"
    exit 1
fi



file1=$1
file2=$2

cat $file1 |  tr " " '\n' | sort -u > /tmp/voc1
cat $file2 |  tr " " '\n' | sort -u > /tmp/voc2



union_size=`cat /tmp/voc1 /tmp/voc2| tr " " '\n' | sort -u | wc -l`
intersection_size=`grep -Fxf /tmp/voc1 /tmp/voc2 | sort -u | wc -l`


vocab1_size=`wc -l /tmp/voc1 | awk '{print $1}'`
vocab2_size=`wc -l /tmp/voc2 | awk '{print $1}'`

intersection_ratio1=`echo "scale=4;  ${intersection_size}/${vocab1_size}" | bc -l`
intersection_ratio2=`echo "scale=4;  ${intersection_size}/${vocab2_size}" | bc -l`


echo "${file1} vocabulary size: ${vocab1_size}"
echo "${file2} vocabulary size: ${vocab2_size}"
echo "${file1} ∪ ${file2} vocabulary size: ${union_size}"
echo "${file1} ∩ ${file2} vocabulary size: ${intersection_size}"

echo "Which accounts for: "
echo -e "\t 0${intersection_ratio1} % of the vocabulary from ${file1}"
echo -e "\t 0${intersection_ratio2} % of the vocabulary from ${file2}"


#rm /tmp/voc1 /tmp/voc2
