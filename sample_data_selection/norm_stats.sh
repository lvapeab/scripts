#!/bin/bash


# num_palabras num_frases OOV_test bigram_cov

cat $1 | awk '{print $1" " $2" "$2/211527" " $3" " $3/20150" " $4 " " $4/12291}' 