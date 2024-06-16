#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate kofamscan;

mkdir output
mkdir temp

echo "exec_annotation --tmp-dir temp -o output/result -p $1 -k $2 --cpu $3 -f $4 $5 $6"

exec_annotation --tmp-dir temp -o output/result -p "$1" -k "$2" --cpu "$3" -f "$4" $5 "$6"
