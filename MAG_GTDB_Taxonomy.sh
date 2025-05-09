#!/bin/bash

BIN_DIR="/data/sms/home/m5/final_filtered_bins"  
OUT_DIR="/data/sms/home/m5/gtdbtk_output"       
SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")  # List of sample directories

mkdir -p "$OUT_DIR"

for SAMPLE in "${SAMPLES[@]}"; do
    echo "Processing $SAMPLE"

    SAMPLE_DIR="$BIN_DIR/$SAMPLE"  # Directory containing refined bins for this sample
    SAMPLE_OUT_DIR="$OUT_DIR/$SAMPLE"  # Output directory for GTDB-Tk results for this sample
    mkdir -p "$SAMPLE_OUT_DIR"

    gtdbtk classify_wf --genome_dir "$SAMPLE_DIR" --out_dir "$SAMPLE_OUT_DIR" -x fasta --skip_ani_screen
    
    echo "GTDB-Tk taxonomic assignment completed for $SAMPLE"
done

echo "All samples processed."

