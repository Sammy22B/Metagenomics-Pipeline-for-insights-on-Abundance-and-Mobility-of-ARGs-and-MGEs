#!/bin/bash

ORF_DIR="/data/sms/home/m5/Prodigal_ORFs" 
READS_DIR="/data/sms/home/m5/OG_READS"     
OUT_DIR="/data/sms/home/m5/ACC_ORF_abundance_op"         
SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")  
LREADS=150                   
mkdir -p "$OUT_DIR"

for SAMPLE in "${SAMPLES[@]}"; do
    echo "Processing $SAMPLE"

    SAMPLE_READS_1="$READS_DIR/${SAMPLE}_1.fastq"  # Forward reads
    SAMPLE_READS_2="$READS_DIR/${SAMPLE}_2.fastq"  # Reverse reads
    SAMPLE_ORF_FILE="$ORF_DIR/${SAMPLE}_prodigal_orfs.fna"  
    SAMPLE_OUT_DIR="$OUT_DIR/$SAMPLE"                 
    mkdir -p "$SAMPLE_OUT_DIR"

    bowtie2-build "$SAMPLE_ORF_FILE" "$SAMPLE_OUT_DIR/${SAMPLE}_ORFs_index"
    bowtie2 -x "$SAMPLE_OUT_DIR/${SAMPLE}_ORFs_index" -1 "$SAMPLE_READS_1" -2 "$SAMPLE_READS_2" -S "$SAMPLE_OUT_DIR/${SAMPLE}_mapped.sam" 2>ACC_ORF_mapping.log

    samtools view -bS "$SAMPLE_OUT_DIR/${SAMPLE}_mapped.sam" > "$SAMPLE_OUT_DIR/${SAMPLE}_mapped.bam"
    samtools sort "$SAMPLE_OUT_DIR/${SAMPLE}_mapped.bam" -o "$SAMPLE_OUT_DIR/${SAMPLE}_mapped_sorted.bam"
    samtools index "$SAMPLE_OUT_DIR/${SAMPLE}_mapped_sorted.bam"

    bedtools coverage -a "$ORF_DIR/${SAMPLE}_output.bed" -b "$SAMPLE_OUT_DIR/${SAMPLE}_mapped_sorted.bam" > "$SAMPLE_OUT_DIR/${SAMPLE}_coverage.txt"
    TOTAL_READS=$(cat "$SAMPLE_READS_1" "$SAMPLE_READS_2" | echo $((`wc -l`/4)))
    DATASET_SIZE=$(echo "scale=6; $TOTAL_READS * $LREADS / 1000000000" | bc)
    TOTAL_ABUNDANCE=0
    while read -r LINE; do
        ORF_NAME=$(echo "$LINE" | awk '{print $1}')         # ORF ID
        NMAPPED_READS=$(echo "$LINE" | awk '{print $4}')    # Number of mapped reads to ORF
        ORF_LENGTH=$(grep -A 1 "$ORF_NAME" "$SAMPLE_ORF_FILE" | tail -n1 | wc -c)  # Length of the ORF

        # Calculate abundance for this ORF using the formula
        ABUNDANCE=$(echo "scale=6; ($NMAPPED_READS * $LREADS) / ($ORF_LENGTH * $DATASET_SIZE)" | bc)

        # Add the ORF abundance to the total sample abundance
        TOTAL_ABUNDANCE=$(echo "$TOTAL_ABUNDANCE + $ABUNDANCE" | bc)
    done < "$SAMPLE_OUT_DIR/${SAMPLE}_coverage.txt"

    # Save the total abundance for the sample
    echo "Total abundance for $SAMPLE: $TOTAL_ABUNDANCE" > "$SAMPLE_OUT_DIR/${SAMPLE}_total_abundance.txt"

    echo "$SAMPLE processing completed."
done

echo "All samples processed."

