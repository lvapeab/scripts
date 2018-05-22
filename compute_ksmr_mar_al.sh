#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Usage: $0 log_file hypothesis_file"
    echo "Processes an al-inmt log (NMT-Keras) and outputs the KSMR"
    exit 1
fi



# Get number of characters:
n_chars=`wc -m $2 | awk '{print $1}'`

# Get number of keystrokes:
n_keystrokes=`grep "Total number of errors:" $1 | awk '{print $5}'`

# Get number of mouse actions:
n_mouse_actions=`grep "Total number selections" $1 | awk '{print $4}'`


echo "($n_keystrokes + $n_mouse_actions) / $n_chars" | bc -l
