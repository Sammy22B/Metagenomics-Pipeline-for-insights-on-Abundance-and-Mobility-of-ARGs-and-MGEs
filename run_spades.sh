#!/bin/bash

outputdir=spades_results 
mkdir $outputdir
forwardreads=(*_1.fastq.gz)

for forwardread in ${forwardreads[@]}
do 
bname=$(basename $forwardread _1.fastq.gz)
reverseread=$(echo $forwardread |sed 's\_1\_2\g')
metaspades.py -1 $forwardread -2 $reverseread -t 40 -o "$outputdir"/"$bname"
done
