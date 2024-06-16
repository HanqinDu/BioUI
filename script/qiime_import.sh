#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate qiime2-2022.2;

export PATH=/home/duhq/miniconda3/envs/R4-server/bin:$PATH;

Rscript "$1" "$2"

mkdir import;

echo "qiime tools import --type $3 --input-path manifest.tsv --output-path import/rawdata.qza --input-format $4"

qiime tools import --type "$3" --input-path manifest.tsv --output-path import/rawdata.qza --input-format "$4"

echo "demux summarize --i-data import/rawdata.qza --o-visualization import/rawdata.qzv"

qiime demux summarize --i-data import/rawdata.qza --o-visualization import/rawdata.qzv

