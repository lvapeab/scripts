#!/bin/bash

usage(){
    echo "Adds the model names, from a deformatted nbest tool (cslm_v2)."
    echo "Usage: split_nbest.sh nbest_file output_prefix"
}
                                                                                                                                         
# fragment the input                                                                                     
nbest=$1
output=$2

echo -n "" > ${output}

while read -r line; do
    new_line=$(echo "$line" | awk 'BEGIN{FS="\\|\\|\\|"}{print $3}'|awk '{print "LexicalReordering0= "$1" "$2" "$3" "$4" " $5" "$6" Distortion0= "$7" LM0= "$8" WordPenalty0= "$9" PhrasePenalty0= "$10" TranslationModel0= "$11" "$12" " $13" "$14  }')
    
    echo "$line" | awk -v line="$new_line" 'BEGIN{FS="\\|\\|\\|"}{$3=line; print $1" ||| "$2" ||| "$3 " ||| "$4}'>>${output}
done <${nbest}
