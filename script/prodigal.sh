#!/bin/bash

LINES=$(cat "$1")

mkdir output
mkdir output/genes
mkdir output/proteins
mkdir output/gff

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate prodigal;

for LINE in $LINES
do
	echo "prodigal -f gff -i input/${LINE} -d output/genes/${LINE} -a output/proteins/${LINE}.faa -p $2 -o output/gff/${LINE}.gff"
	prodigal -f gff -i "input/$LINE" -d "output/genes/$LINE" -a "output/proteins/$LINE.faa" -p "$2" -o "output/gff/$LINE.gff"
done

rename "s/\.[_a-zA-Z]*\.faa$/.faa/" output/proteins/*
rename "s/\.[_a-zA-Z]*\.gff$/.gff/" output/gff/*
