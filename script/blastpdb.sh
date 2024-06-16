#!/bin/bash

LINES=$(find dbseq/*)

for LINE in $LINES
do
	cat "$LINE" >> genome_all.fasta;
	echo '\n' >> genome_all.fasta;
done

mkdir dbtemp

echo "makeblastdb -in genome_all.fasta -dbtype prot -parse_seqids -out dbtemp/dbtemp -title temp database"
makeblastdb -in genome_all.fasta -dbtype prot -parse_seqids -out "dbtemp/dbtemp" -title "temp database"