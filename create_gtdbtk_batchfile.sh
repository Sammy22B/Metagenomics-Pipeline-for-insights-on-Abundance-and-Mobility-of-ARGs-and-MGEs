#!/bin/bash

# Define the directories where the input FASTA files are located and where the output batchfiles will be saved
INPUT_DIR="/data/sms/home/m5/sneha/ARG_CContigs"
OUTPUT_DIR="/data/sms/home/m5/GTDBTk_Classification"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through all sample IDs
for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813
do
    # Path to the FASTA file for the current sample
    FASTA_FILE="${INPUT_DIR}/${sample}_arg_carrying_contigs.fa"
    
    # Output batchfile for the current sample
    BATCHFILE="${OUTPUT_DIR}/${sample}_batchfile.tsv"

    # Initialize the batchfile (clear if exists or create new)
    > "$BATCHFILE"

    # Check if the FASTA file exists
    if [ ! -f "$FASTA_FILE" ]; then
        echo "FASTA file not found: $FASTA_FILE"
        continue
    fi

    # Write only the path to the FASTA file, genome ID (sample name), and translation table (set to 11 by default)
    echo -e "${FASTA_FILE}\t${sample}\t11" >> "$BATCHFILE"

    echo "Batchfile created for $sample: $BATCHFILE"
done

echo "Batchfile generation complete for all samples."

