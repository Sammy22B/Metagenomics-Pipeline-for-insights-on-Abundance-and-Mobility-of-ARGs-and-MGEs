#!/bin/bash

FILTERED_OUTPUT_DIR="/data/sms/home/m5/filtered_bins_outliers"
TAXON_FILTER_OUTPUT="taxon_filter.tsv"
FINAL_FILTERED_DIR="/data/sms/home/m5/final_filtered_bins"

# Create output directory if it does not exist
mkdir -p "$FINAL_FILTERED_DIR"

# Loop through filtered bins and apply taxonomy-based filtering
for filtered_bin in "$FILTERED_OUTPUT_DIR"/SRR127388*; do
    contig_name=$(basename "$filtered_bin")  # extract SRR ID
    echo "Filtering bin based on taxonomic inconsistencies: $contig_name"
    refinem filter_bins -x fasta "$filtered_bin" "$TAXON_FILTER_OUTPUT" "$FINAL_FILTERED_DIR/$contig_name"
done

