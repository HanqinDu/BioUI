#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate compareM;


EXPRESS="s/\.?[_a-zA-Z]*$/.${3}/"

rename "${EXPRESS}" input/*

echo "comparem aai_wf -x $3 -c $1 $2 input output"

comparem aai_wf -x "$3" -c "$1" $2 input output


export PATH=/home/duhq/miniconda3/envs/R4/bin:$PATH;

Rscript /home/duhq/BioUI_script/comparem_to_matrix.R



