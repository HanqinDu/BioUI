#!/bin/bash

echo '' > log.txt;
echo '' > log_error.txt;

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate qiime2-2022.2;

rm -r -f diversity;

if [ -f "cluster/OTU_table.qza" ]
then
TABLE=cluster/OTU_table.qza
else
TABLE=quality_control/treated_table.qza
fi


qiime diversity core-metrics-phylogenetic \
  --p-n-jobs-or-threads "auto" \
  --i-phylogeny phylogeny/rooted-tree.qza \
  --i-table "$TABLE" \
  --p-sampling-depth "$1" \
  --m-metadata-file metadata.tsv \
  --output-dir diversity



qiime diversity alpha-group-significance \
  --i-alpha-diversity diversity/faith_pd_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization diversity/faith_pd_group_significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity diversity/evenness_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization diversity/evenness_group_significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity diversity/shannon_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization diversity/shannon_group_significance.qzv




COLUMNS=$(cat "groupby.txt")

for COLUMN in $COLUMNS
do

qiime diversity beta-group-significance \
  --i-distance-matrix diversity/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column $COLUMN \
  --o-visualization "diversity/unweighted_unifrac_${COLUMN}_significance.qzv" \
  $2

done




#qiime emperor plot \
#  --i-pcoa diversity/unweighted_unifrac_pcoa_results.qza \
#  --m-metadata-file metadata.tsv \
#  --o-visualization "diversity/unweighted-unifrac-emperor.qzv"

#qiime emperor plot \
#  --i-pcoa diversity/bray_curtis_pcoa_results.qza \
#  --m-metadata-file metadata.tsv \
#  --o-visualization diversity/bray-curtis-emperor.qzv



