#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate perl5;

export PATH=/home/duhq/miniconda3/envs/R4/bin:$PATH;

echo "perl $1 -ID:$3 -CV:$4 -BT:$5 -EVAL:$6"
echo "Rscript $2"

perl $1 -ID:$3 -CV:$4 -BT:$5 -EVAL:$6

Rscript $2
