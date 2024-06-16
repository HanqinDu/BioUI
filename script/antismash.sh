#!/bin/bash

# TAXON can be bacteria or fungi
# GENEFINDING can be GlimmerHMM, Prodigal or none
TASK=$1
IMAGEID=$2
SCRIPTPATH=$3
VOLUMEPATH=$4
CPUS=$5
TAXON=$6
GENEFINDING=$7


cp ${SCRIPTPATH} ${VOLUMEPATH}

mkdir ${VOLUMEPATH}/output


docker run \
--entrypoint /bin/bash \
--name ${TASK} \
-v "${VOLUMEPATH}:/workspace" \
${IMAGEID} \
/workspace/antismash_docker.sh ${CPUS} ${TAXON} ${GENEFINDING}


docker rm -v ${TASK}


echo "done"
