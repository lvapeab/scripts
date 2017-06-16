#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Usage: `basename $0` data_file1 [data_file2, ..., data_fileN]"
    echo "Plots data_files into a 2D linesplot"
    exit 1
fi

gnuplot -p << eof

set style data lines
set term wxt size 1200,900 title 'plots'
set log x
set xlabel 'LR'
set ylabel 'BLEU'
set yrange [0.15:0.25]
set key left
set format x "%.0s*10^%T"

set terminal pngcairo
plot for [ file in "$@" ] file using 1:2 with lines title file

eof
