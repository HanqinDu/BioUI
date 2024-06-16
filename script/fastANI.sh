#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate fastANI;

echo "fastANI --ql $1 --rl $2 --matrix -o $3 $4"
fastANI --ql "$1" --rl "$2" --matrix -o "$3" $4
