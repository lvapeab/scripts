#!/bin/bash


if [ $# -lt 1 ] 
then 
    echo "Usage: $0 text_file"
    echo "Computes the vocabulary size of text_file"
    exit 1
fi


for file in  $* ;do
  ngram-count -lm /dev/null -order 1 -write-vocab /tmp/voc -text $file 2> /dev/null
  vocab=`wc -l /tmp/voc |awk '{print $1}'`
  echo "$file: $vocab"
done
rm /tmp/voc
 
