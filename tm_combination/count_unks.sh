#!/bin/bash




file=$1




cat  $file | awk '{n=0; for(i=0; i< NF; i++){if($i == "UNK") n++;} print n}'
