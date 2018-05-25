#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Usage: $0 log_file references_file"
    echo "Processes an al-inmt log (NMT-Keras) and outputs the bleu of the selected sentences for AL."
    exit 1
fi



# Get indices of the sentences selected
grep "Processing sentence " $1 | awk '{print ($3+1)}'> /tmp/sents_indices

selected_instances=`wc -l  /tmp/sents_indices |awk '{print $1}'`

if [ "${selected_instances}" == "0" ] ; then # We are with a post-editing log
    grep "Hypo_0" $1 | awk '{print ($4 +1)}' > /tmp/sents_indices
fi

# Get hypotheses
grep "Hypo_0" $1 |awk 'BEGIN{FS=":"}{ for(i=4; i<NF; i++) printf "%s",$i OFS; if(NF) printf "%s",$NF; printf ORS}' > /tmp/hypotheses
# Get corresponding references
awk 'NR == FNR { selected[$1] = 1; next } selected[FNR]'  /tmp/sents_indices $2 > /tmp/references
# Compute BLEU
calc_bleu -r /tmp/references -t /tmp/hypotheses
