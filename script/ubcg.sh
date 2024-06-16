#!/bin/bash

LINES=$(cat "$1")

mkdir "$2/output";
mkdir "$2/bcg";

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate UBCG;

for LINE in $LINES
do
	echo "java -jar UBCG.jar extract -i $2/input/${LINE} -bcg_dir $2/bcg -label ${LINE} -t $3"
	java -jar UBCG.jar extract -i "$2/input/$LINE" -bcg_dir "$2/bcg" -label "$LINE" -t "$3"
done

echo "java -jar UBCG.jar align -bcg_dir $2/bcg -out_dir $2/output -a $4 -t $3"
java -jar UBCG.jar align -bcg_dir "$2/bcg" -out_dir "$2/output" -a "$4" -t "$3"
