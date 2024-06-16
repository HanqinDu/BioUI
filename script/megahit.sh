#!bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate megahit;

echo "megahit -t $1 --k-min $2 --k-max $3 --k-step $4 $5 $6 -o output"

megahit -t "$1" --k-min "$2" --k-max "$3" --k-step "$4" $5 $6 -o "output"
