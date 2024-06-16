#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate iqtree;

mkdir output;

echo "iqtree -s input --prefix output/partition -T $1 $2"

iqtree -s input --prefix output/partition -T "$1" $2
