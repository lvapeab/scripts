#!/bin/bash


src=training.es
trg=training.en

out=dev

paste -d "\t" ${src} ${trg} | shuf | head -n 1000 > ${out}

cat dev | awk 'BEGIN{FS = "\t"}; {print $2}'>${out}.en
cat dev | awk 'BEGIN{FS = "\t"}; {print $1}'>${out}.es
