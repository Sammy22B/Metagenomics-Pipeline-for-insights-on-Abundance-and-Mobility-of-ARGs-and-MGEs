#!/bin/bash

BIN_DIR="/data/sms/home/m5/final_filtered_bins"  # Directory containing sample subdirectories with refined bins
OUT_DIR="/data/sms/home/m5/comparative_output"   # Output directory for CompareM results
SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")  # List of samples

mkdir -p "$OUT_DIR"

for SAMPLE in "${SAMPLES[@]}"; do
    echo "Processing $SAMPLE"

    SAMPLE_DIR="$BIN_DIR/$SAMPLE"  # Directory containing refined bins for this sample
    GENOME_LIST_FILE="$OUT_DIR/${SAMPLE}_genomes_list.txt"  # File to store paths of all genomes (bins)

    # Create a text file containing paths to all .fasta bin files for CompareM input
    ls "$SAMPLE_DIR"/*.fasta > "$GENOME_LIST_FILE"

    # Create output directory for CompareM results for this sample
    SAMPLE_OUT_DIR="$OUT_DIR/$SAMPLE"
    mkdir -p "$SAMPLE_OUT_DIR"

    # Run CompareM AAI workflow on the genome list file
    comparem aai_wf -x fasta "$GENOME_LIST_FILE" "$SAMPLE_OUT_DIR"
    
    echo "CompareM AAI completed for $SAMPLE"
done

echo "All samples processed."

