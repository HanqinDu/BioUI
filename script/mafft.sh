#!/bin/bash

#. /home/duhq/miniconda3/etc/profile.d/conda.sh;
#conda activate mafft;

mkdir output;

echo "$3 --thread $2 $1 > output/alignment.fasta"

$3 --thread "$2" "$1" > output/alignment.fasta
