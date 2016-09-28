#!/bin/bash

usage(){
    echo "Removes the model names, for nbest tool of cslm_v2."
    echo "Usage: split_nbest.sh nbest_file output_prefix"
}
                                                                                                                                         
# fragment the input                                                                                     
nbest=$1
output=$2

echo -n "" > ${output}

while read -r line; do
    new_line=$(echo "$line" | awk 'BEGIN{FS="\\|\\|\\|"}{print $3}'  | awk '{print $2" "$3" "$4" "$5" " $6" "$7" "$9" "$11" "$13" "$15" "$17" "$18" " $19" "$20  }')
    echo "$line" | awk -v line="$new_line" 'BEGIN{FS="\\|\\|\\|"}{$3=line; print $1" ||| "$2" ||| "$3" |||" $4}'>>${output}
done <${nbest}

