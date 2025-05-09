#!/bin/bash
for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813; do 
for fasta in curated_BINS/$sample/*fa; do 
base_name=$(basename $fasta .fasta)
bowtie2-build $fasta $fasta.index
bowtie2 -x $fasta.index -1 $sample"_1.fastq.gz" -2 $sample"_2.fastq.gz" -S $sample.$base_name.sam
samtools view -bS $sample.$base_name.sam | samtools sort -o $sample.$base_name.sorted.bam
samtools index $sample.$base_name.sorted.bam
rm $sample.$base_name.sam
done 
done
