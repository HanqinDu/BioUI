#!/bin/bash

GENOS=$(cat "$2")
CDSS=$(cat "$3")
PROTS=$(cat "$4")

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate ezaai;

mkdir profile;

for GENO in $GENOS
do
	echo "java -jar $1 extract -i input/$GENO -o profile/$GENO"
	java -jar "$1" extract -i "input/$GENO" -o "profile/$GENO"
done

for CDS in $CDSS
do
	echo "java -jar $1 convert -i input/$CDS -s nucl -o profile/$CDS"
	java -jar "$1" convert -i "input/$CDS" -s nucl -o "profile/$CDS"
done

for PROT in $PROTS
do
	echo "java -jar $1 convert -i input/$PROT -s prot -o profile/$PROT"
	java -jar "$1" convert -i "input/$PROT" -s prot -o "profile/$PROT"
done

rename "s/\.[_a-zA-Z]*$/.profile/" profile/*;


echo "java -jar $1 calculate -i profile -j profile -o ${5}_AAI.txt -mtx -t $6"
java -jar "$1" calculate -i profile -j profile -o "${5}_AAI.txt" -mtx -t "$6"

echo "java -jar $1 cluster -i ${5}_AAI.txt -o ${5}_cluster.txt"
java -jar "$1" cluster -i "${5}_AAI.txt" -o "${5}_cluster.txt"


