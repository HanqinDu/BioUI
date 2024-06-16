#!bin/bash

rename "s/ /_/g" input/*
rename "s/\.[_a-zA-Z]*$//g" input/*
rename "s/\.//g" input/*

LINES=$(ls input)

for LINE in $LINES
do
	sed -i "s/>.*$/>$LINE/g" "input/$LINE"
done



LINES=$(ls input)

for LINE in $LINES
do
	echo "${LINE},$(${2} "input/${LINE}" "input/regulized_${LINE}")" >> protein_count.csv
	rm "input/$LINE"
done




. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate blast;

LINES=$(ls input)

echo '' > protein_all.fasta;

for LINE in $LINES
do
	cat "input/$LINE" >> protein_all.fasta;
	echo '\n' >> protein_all.fasta;
done

mkdir dbtemp

makeblastdb -in protein_all.fasta -dbtype prot -parse_seqids -out "dbtemp/dbtemp" -title "temp database"

blastp -db dbtemp/dbtemp -query protein_all.fasta -out "blastp_result.csv" -num_threads ${4} -task blastp -subject_besthit -evalue 0.00001 -outfmt "10 delim=, qseqid sseqid pident qstart qend qlen"



export PATH=/home/duhq/miniconda3/envs/R4/bin:$PATH;

Rscript ${3} ${1}
