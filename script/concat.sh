#!bin/bash

LINES=$(ls input/*)

for LINE in $LINES
do
	cat "$LINE" >> concated.fasta;
	echo '\n' >> concated.fasta;
done
