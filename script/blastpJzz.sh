#!/bin/bash

LINES=$(cat "$1")

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate blast;

mkdir output;

for LINE in $LINES
do
	echo "blastp -db $2 -query $LINE -out output/$LINE -num_threads $3 -task $4 -outfmt $5 $6"
	blastp -db "$2" -query "$LINE" -out "output/$LINE" -num_threads "$3" -task "$4" -outfmt "$5" $6
done

rename "s/\.[_a-zA-Z]*$/.alignment/" output/*
