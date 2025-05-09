#!/bin/bash

outputdir=megahit2_results 
mkdir $outputdir
forwardreads=(deduplicated*_R1.fastq.gz)

for forwardread in ${forwardreads[@]}
do 
bname=$(basename $forwardread _R1.fastq.gz)
reverseread=$(echo $forwardread |sed 's\_R1\_R2\g')
megahit -1 $forwardread -2 $reverseread --k-min 27 --k-max 127 --k-step 10 --min-contig-len 1000 -t 34 -o "$outputdir"/"$bname"
done 
