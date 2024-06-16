#!/bin/bash

echo '' > log.txt;
echo '' > log_error.txt;

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate qiime2-2022.2;

export PATH=/home/duhq/miniconda3/envs/R4-server/bin:$PATH;

rm -r -f quality_control;

mkdir quality_control;



echo "$1"
qiime $1


echo "qiime metadata tabulate --m-input-file metadata.tsv --o-visualization quality_control/treated_stats.qzv"
qiime metadata tabulate --m-input-file metadata.tsv --o-visualization quality_control/treated_stats.qzv


echo "qiime feature-table tabulate-seqs --i-data quality_control/treated_rep_seqs.qza --o-visualization quality_control/treated_rep_seqs.qzv"
qiime feature-table tabulate-seqs --i-data quality_control/treated_rep_seqs.qza --o-visualization quality_control/treated_rep_seqs.qzv


echo "qiime feature-table summarize --i-table quality_control/treated_table.qza --o-visualization quality_control/treated_table.qzv --m-sample-metadata-file metadata.tsv"
qiime feature-table summarize --i-table quality_control/treated_table.qza --o-visualization quality_control/treated_table.qzv --m-sample-metadata-file metadata.tsv
