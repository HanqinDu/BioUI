#!/bin/bash

LINES=$(ls input)

mkdir output

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate prokka;

for LINE in $LINES
do
	echo "prokka --cpus $1 --kingdom $2 --outdir output/${LINE} $3 input/${LINE}"
	prokka --cpus "$1" --kingdom "$2" --outdir "output/$LINE" $3 "input/$LINE"
done
