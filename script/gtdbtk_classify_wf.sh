#!/bin/bash

rename "s/\.[_a-zA-Z]*$/.fasta/" input/*;
. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate gtdbtk;

mkdir output

echo "gtdbtk classify_wf -x fasta --cpus $1 --genome_dir input --out_dir output --pplacer_cpus 1"

gtdbtk classify_wf -x fasta --cpus "$1" --genome_dir input --out_dir output --pplacer_cpus 1
