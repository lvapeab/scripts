#!/bin/bash




lm=$1
text=$2

ngram -lm $lm -ppl $text -debug 2 -unk |grep logprob |awk '{print $4}'

