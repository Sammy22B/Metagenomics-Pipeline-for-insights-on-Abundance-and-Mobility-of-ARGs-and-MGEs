#!/bin/bash

FILTERED_OUTPUT_DIR="/data/sms/home/m5/filtered_bins_outliers"
GENE_OUTPUT_DIR="/data/sms/home/m5/gene_output"

# Create output directory if it does not exist
mkdir -p "$GENE_OUTPUT_DIR"

# Loop through each filtered bin and call genes
for filtered_bin in "$FILTERED_OUTPUT_DIR"/SRR127388*; do
    contig_name=$(basename "$filtered_bin")  # extract SRR ID
    echo "Calling genes for sample: $contig_name"
    refinem call_genes -c 40 -x fasta "$filtered_bin" "$GENE_OUTPUT_DIR/$contig_name"
done

