#!/bin/bash

destdir=`dirname $1`
base=`basename $1`
basename="${base%.*}"

cat $1 |grep "WORD STROKES:" |awk '{ {print $3}}' > /tmp/${basename}.w_strokes
cat $1 |grep "WORD STROKES:" |awk '{ {print $3+1}}' > /tmp/${basename}.c_strokes
cat $1 |grep "REFERENCE:" |awk '{ {print NF-1}}' > /tmp/${basename}.n_words
cat $1 |grep "REFERENCE:" |awk '{ chars=0; for (i=2; i<=NF; i++) chars= chars+length($i); print chars}' > /tmp/${basename}.n_chars

paste -d " " /tmp/${basename}.w_strokes /tmp/${basename}.n_words | awk '{print $1 / $2}'> /tmp/${basename}.wsr

paste -d " " /tmp/${basename}.c_strokes /tmp/${basename}.n_chars | awk '{print $1 / $2}'> /tmp/${basename}.mar

paste -d " " /tmp/${basename}.wsr /tmp/${basename}.mar >${destdir}/${basename}.scores



#  |awk 'BEGIN{FS="."}{print "0."$2" 0."$4}' > ${destdir}/${basename}.scores
