#!/bin/bash

# $1: File with NN sentence log probabilities
# $2: File with n-gram sentence log probabilities
# $3: Interpolation weight given to NN 

rnn_probs=$1
ngr_probs=$2
lambda=$3


while read -r -u 4 srilm && read -r -u 5 rnnlm ;
do
    echo "$rnnlm*$lambda + $srilm*(1-$lambda)" |bc ;
done 4<$ngr_probs 5<$rnn_probs


