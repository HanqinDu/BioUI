#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate quast;

mkdir output;

echo "quast.py -o output -t $1 $2 $3"

quast.py -o "output" -t "$1" $2 $3 

