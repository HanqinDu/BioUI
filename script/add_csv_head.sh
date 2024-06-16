#!/bin/bash

LINES=$(find output/*)

for LINE in $LINES
do
	sed -i '1s/^/Query Seq-id,Subject Seq-id,Percentage of identical matches,means Query Coverage Per HSP,Alignment length,Start of alignment in query,End of alignment in query,Start of alignment in subject,End of alignment in subject,Expect value,Bit score,Aligned part of query sequence,Aligned part of subject sequence\n/' "$LINE"
	mv "$LINE" "${LINE}.csv"
done
