#!/bin/bash

echo '' > log.txt;
echo '' > log_error.txt;

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate qiime2-2022.2;

rm -r -f phylogeny;

mkdir phylogeny;

if [ -f "cluster/OTU_rep_seqs.qza" ]
then
REPSEQ=cluster/OTU_rep_seqs.qza
TABLE=cluster/OTU_table.qza
else
REPSEQ=quality_control/treated_rep_seqs.qza
TABLE=quality_control/treated_table.qza
fi


echo "qiime phylogeny align-to-tree-mafft-${1} --i-sequences ${REPSEQ} --o-alignment phylogeny/aligned-rep-seqs.qza --o-masked-alignment phylogeny/masked-aligned-rep-seqs.qza --o-tree phylogeny/unrooted-tree.qza --o-rooted-tree phylogeny/rooted-tree.qza $2"
qiime phylogeny "align-to-tree-mafft-${1}" --i-sequences "$REPSEQ" --o-alignment phylogeny/aligned-rep-seqs.qza --o-masked-alignment phylogeny/masked-aligned-rep-seqs.qza --o-tree phylogeny/unrooted-tree.qza --o-rooted-tree phylogeny/rooted-tree.qza $2

qiime diversity alpha-rarefaction \
  --i-table "$TABLE" \
  --i-phylogeny phylogeny/rooted-tree.qza \
  --p-max-depth "$3" \
  --m-metadata-file metadata.tsv \
  --o-visualization phylogeny/alpha-rarefaction.qzv

