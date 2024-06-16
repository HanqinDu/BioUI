#!/bin/bash

LINES=$(cat "$1")

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate eggnog-mapper;

mkdir output;

for LINE in $LINES
do
	echo "emapper.py -i "input/$LINE" -o "output/$LINE" --data_dir /home/duhq/Database/eggnog $2"
	emapper.py -i "input/$LINE" -o "output/$LINE" --data_dir /home/duhq/Database/eggnog $2
done

