#!/bin/bash

scores=$1
ppls=$2
out_file=$3

echo -n "" > $out_file
while read -r -u 4 sent_file && read -r -u 5 interp_prob ;
do
echo "$sent_file"   | awk -v newp=$interp_prob  '{
if($3="logprob="){ $4=newp; print $0;}
else print $0;
 }' >> $out_file
done 4<$ppls  5<$scores

