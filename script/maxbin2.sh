#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate maxbin2;

mkdir output;

gunzip $(ls *.gz)

echo "run_MaxBin.pl -thread $1 -contig $2 -out output/bin -min_contig_length $3 -max_iteration $4 -prob_threshold $5 -markerset $6 $7"

run_MaxBin.pl -thread $1 -contig $2 -out output/bin -min_contig_length $3 -max_iteration $4 -prob_threshold $5 -markerset $6 $7

echo "done"
