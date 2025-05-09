#!/bin/bash

outputdir=new_megahit_results 
mkdir $outputdir
forwardreads=(*_1.fastq.gz)

for forwardread in ${forwardreads[@]}
do 
bname=$(basename $forwardread _1.fastq.gz)
reverseread=$(echo $forwardread |sed 's\_1\_2\g')
megahit -1 $forwardread -2 $reverseread --k-min 27 --k-max 127 --k-step 10 --min-contig-len 1000 -t 34 -o "$outputdir"/"$bname"
done 
