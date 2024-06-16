#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate SPAdes;

export PATH=/home/duhq/miniconda3/envs/R4/bin:$PATH;

mkdir output;

echo "spades.py -t $1 $2 -o output"

spades.py -t "$1" $2 -o "output"

$3 "output/contigs.fasta" "output/contigs_info.csv"

Rscript $4 "output/contigs_info.csv" "output/coverage_density.svg" "output/length_density.svg"

