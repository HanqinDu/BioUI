#!/bin/bash

LINES=$(cat "$1")

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate barrnap;

mkdir output;
mkdir output/fa;
mkdir output/gff;

for LINE in $LINES
do
	echo "barrnap -k $2 -t $3 -o output/fa/${LINE}.fa input/${LINE} > output/gff/${LINE}.gff"
	barrnap -k "$2" -t "$3" -o "output/fa/$LINE.fa" "input/$LINE" > "output/gff/$LINE.gff"
done

rename "s/\.[_a-zA-Z]*\.fa$/_rRNA.fa/" output/fa/*
rename "s/\.[_a-zA-Z]*\.gff$/_rRNA.gff/" output/gff/*
