#!/bin/bash

echo '' > log.txt;
echo '' > log_error.txt;

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate qiime2-2022.2;

rm -r -f taxonomy

mkdir taxonomy

if [ -f "cluster/OTU_rep_seqs.qza" ]
then
REPSEQ=cluster/OTU_rep_seqs.qza
TABLE=cluster/OTU_table.qza
else
REPSEQ=quality_control/treated_rep_seqs.qza
TABLE=quality_control/treated_table.qza
fi


echo "qiime feature-classifier classify-sklearn --p-n-jobs -1 --i-reads ${REPSEQ} --o-classification taxonomy/taxonomy.qza ${1}"
qiime feature-classifier classify-sklearn \
  --p-n-jobs -1 \
  --i-reads "$REPSEQ" \
  --o-classification taxonomy/taxonomy.qza \
  $1


echo "qiime metadata tabulate --m-input-file taxonomy/taxonomy.qza --o-visualization taxonomy/taxonomy.qzv"
qiime metadata tabulate \
  --m-input-file taxonomy/taxonomy.qza \
  --o-visualization taxonomy/taxonomy.qzv


echo "qiime taxa barplot --i-table {$TABLE} --i-taxonomy taxonomy/taxonomy.qza --m-metadata-file metadata.tsv --o-visualization taxonomy/taxa-bar-plots.qzv"
qiime taxa barplot \
  --i-table "$TABLE" \
  --i-taxonomy taxonomy/taxonomy.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization taxonomy/taxa-bar-plots.qzv

