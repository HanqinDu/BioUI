#!/bin/bash

LINES=$(cat "$1")

mkdir output;
mkdir output/final_results;
mkdir output/secondary_structure;
mkdir output/summary;

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate tRNAscan-SE;

for LINE in $LINES
do
	echo "tRNAscan-SE $2 $3 $4 $5 -o output/final_results/${LINE} -f output/secondary_structure/${LINE} -m output/summary/${LINE} input/${LINE}"
	tRNAscan-SE $2 $3 $4 $5 -o "output/final_results/$LINE" -f "output/secondary_structure/$LINE" -m "output/summary/$LINE" "input/$LINE"
done
