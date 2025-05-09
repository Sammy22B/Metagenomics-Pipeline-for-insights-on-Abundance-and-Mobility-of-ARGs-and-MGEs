#!/bin/bash

# Directories
BIN_DIR="/data/sms/home/m5/final_filtered_bins"  # Directory containing sample subdirectories with refined bins
OUT_DIR="/data/sms/home/m5/gtdbtk_denovo_output"        # Output directory for GTDB-Tk results
SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")  # List of sample directories

# Create output directory if it doesn't exist
mkdir -p "$OUT_DIR"

# Loop through each sample
for SAMPLE in "${SAMPLES[@]}"; do
    echo "Processing $SAMPLE"

    SAMPLE_DIR="$BIN_DIR/$SAMPLE"  # Directory containing refined bins for this sample
    SAMPLE_OUT_DIR="$OUT_DIR/$SAMPLE"  # Output directory for GTDB-Tk results for this sample

    # Create output directory for this sample
    mkdir -p "$SAMPLE_OUT_DIR"

    # Run GTDB-Tk on the bins (MAGs) of the current sample
    gtdbtk de_novo_wf --genome_dir "$SAMPLE_DIR" --bacteria --outgroup_taxon p__Patescibacteria --out_dir "$SAMPLE_OUT_DIR" -x fasta 
    
    echo "GTDB-Tk taxonomic assignment completed for $SAMPLE"
done

echo "All samples processed."
