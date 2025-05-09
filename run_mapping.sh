#!/bin/bash
ASSEMBLY_DIR=~/Megahit_Results
READS_DIR=~/OG_READS
SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for SRR in "${SRR_IDS[@]}"
do
echo "Processing $SRR"
bowtie2-build ${ASSEMBLY_DIR}/${SRR}_Assembled.contigs.fa ${SRR}_index
bowtie2 -x ${SRR}_index -1 ${READS_DIR}/${SRR}_1.fastq -2 ${READS_DIR}/${SRR}_2.fastq -S ${SRR}_mapped.sam
samtools view -bS ${SRR}_mapped.sam > ${SRR}_mapped.bam
samtools sort ${SRR}_mapped.bam -o ${SRR}_mapped_sorted.bam
samtools index ${SRR}_mapped_sorted.bam
echo "$SRR mapping complete"
done

