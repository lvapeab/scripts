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



union_size=`cat /tmp/voc1 /tmp/voc2| tr " " '\n' | sort -u |wc -l`
intersection_size=`grep -f /tmp/voc1 /tmp/voc2 | sort -u | wc -l`


vocab1_size=`wc  -l /tmp/voc1 `
vocab2_size=`wc -l /tmp/voc2`


echo "$file1 vocabulary size: $vocab1_size"
echo "$file2 vocabulary size: $vocab2_size"
echo "$file1 ∪ $file2 vocabulary size: $union_size"
echo "$file1 ∩ $file2 vocabulary size: $intersection_size"

rm /tmp/voc1 /tmp/voc2
