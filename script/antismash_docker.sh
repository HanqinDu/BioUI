#!/bin/bash


CPUS=$1
TAXON=$2
GENEFINDING=$3


cd /workspace


INPUTS=$(ls input)

for INPUT in ${INPUTS}
do

echo "antismash -c ${CPUS} --taxon ${TAXON} --fullhmmer --output-dir /workspace/output input/${INPUT}"

antismash \
-c ${CPUS} \
--taxon ${TAXON} \
--fullhmmer \
--genefinding-tool ${GENEFINDING} \
--output-dir /workspace/output \
input/${INPUT}


done


chmod -R 777 /workspace


echo "done"

