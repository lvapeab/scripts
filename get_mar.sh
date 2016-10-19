#!/bin/bash


if [ $# -ne 2 ] 
then 
    echo "Usage: $0 inmt_log references"
    echo "Computes the true MAR  of inmt_log (Avoiding python unicode problems)"
    exit 1
fi



# Join corpus and get hypotheses
#cat $1 |grep "Final hypotesis:" |cut -d " " -f 5-  >  hyp

# Get counts
cat $2 | sed "s/ //g" | awk '{ print length($0); }' > /tmp/lengths

# Get mouse strokes
cat  $1  |grep "Sentence mouse strokes: " |cut -d " " -f 4- |awk '{print $8}'  >  /tmp/strokes

# Get true mars
paste /tmp/strokes /tmp/lengths | awk '{print ($1 / $2)}' > /tmp/mars

# Get wsr
cat  $1  |grep "Sentence WSR" |awk '{print $6}'|awk 'BEGIN{FS="."}{print "0."$2}'  >  /tmp/wsr

# Get scores 
paste /tmp/wsr /tmp/mars -d " "
#rm /tmp/wsr /tmp/mars
