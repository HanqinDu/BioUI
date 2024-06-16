#!/bin/bash

rename "s/\.[_a-zA-Z]*$/.faa/" bin/*;
. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate checkM;

echo "checkm lineage_wf --genes -x faa bin output $1"

checkm lineage_wf --genes -x faa bin output $1

${2} "output/storage/bin_stats_ext.tsv" "output/bin_stats_ext_reform.csv"

