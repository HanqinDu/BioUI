#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate ML;

export PATH=/home/duhq/miniconda3/envs/R4-server/bin:$PATH;

python $1 $4

Rscript $2 $4 $5 $6

$3 -fastq_mergepairs trimed_R1.fastq -fastaout merged.fasta -fastqout merged.fastq -tabbedout merge_report.txt
