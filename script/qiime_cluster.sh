#!/bin/bash

echo '' > log.txt;
echo '' > log_error.txt;

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate qiime2-2022.2;

export PATH=/home/duhq/miniconda3/envs/R4-server/bin:$PATH;

rm -r -f cluster;

mkdir cluster;


echo "qiime vsearch cluster-features-de-novo --i-table quality_control/treated_table.qza --i-sequences quality_control/treated_rep_seqs.qza --p-perc-identity $1 --o-clustered-table cluster/OTU_table.qza --o-clustered-sequences cluster/OTU_rep_seqs.qza"
qiime vsearch cluster-features-de-novo \
  --i-table quality_control/treated_table.qza \
  --i-sequences quality_control/treated_rep_seqs.qza \
  --p-perc-identity "$1" \
  --o-clustered-table cluster/OTU_table.qza \
  --o-clustered-sequences cluster/OTU_rep_seqs.qza


echo "qiime feature-table tabulate-seqs --i-data cluster/OTU_rep_seqs.qza --o-visualization cluster/OTU_rep_seqs.qzv"
qiime feature-table tabulate-seqs --i-data cluster/OTU_rep_seqs.qza --o-visualization cluster/OTU_rep_seqs.qzv


echo "feature-table summarize --i-table cluster/OTU_table.qza --o-visualization cluster/OTU_table.qzv --m-sample-metadata-file metadata.tsv"
qiime feature-table summarize --i-table cluster/OTU_table.qza --o-visualization cluster/OTU_table.qzv --m-sample-metadata-file metadata.tsv
