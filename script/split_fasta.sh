#!bin/bash

LINES=$(cat "$1")

mkdir output

for LINE in $LINES
do
	mkdir output/$LINE
	${2} "input/$LINE" "output/$LINE"
done
