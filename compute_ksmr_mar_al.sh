#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Usage: $0 log_file hypothesis_file"
    echo "Processes an al-inmt log (NMT-Keras) and outputs the KSMR"
    exit 1
fi



# Get number of characters:
n_chars=`wc -m $2 | awk '{print $1}'`

n_errors_mouse=`grep "errors. Sentence WSR:" $1 | awk 'BEGIN {n_errors=0; n_mouse=0;} {n_errors+=$3; n_mouse+=$11;} END{print n_errors"\t"n_mouse;}'`


# Get number of keystrokes:
n_keystrokes=`echo "$n_errors_mouse" |  cut -f 1`

# Get number of mouse actions:
n_mouse_actions=`echo "$n_errors_mouse" |  cut -f 2`


echo "($n_keystrokes + $n_mouse_actions) / $n_chars" | bc -l
