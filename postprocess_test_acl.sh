#!/bin/bash

in_file=$1
out_file=$2
moses_path=/home/lvapeab/smt/software/mosesdecoder/scripts/tokenizer

perl ${moses_path}/normalize-punctuation.perl -l de < $in_file > /tmp/file.norm
perl ${moses_path}/lowercase.perl < /tmp/file.norm > /tmp/file.norm.lc
perl ${moses_path}/detokenizer.perl -l de </tmp/file.norm.lc > $out_file



