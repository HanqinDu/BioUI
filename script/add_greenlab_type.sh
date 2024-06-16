#!/bin/bash

export PATH=/home/duhq/miniconda3/envs/R4/bin:$PATH;

LINES=$(find output/*)

echo "Rscript $1 $2 $3 $LINES"

Rscript "$1" "$2" "$3" $LINES

