#!/bin/bash

BIN_DIR="/data/sms/home/m5/curated_BINS"
OUTLIER_OUTPUT_DIR="/data/sms/home/m5/outlier_output"
FILTERED_OUTPUT_DIR="/data/sms/home/m5/filtered_bins_outliers"

mkdir -p "$FILTERED_OUTPUT_DIR"

for outlier in "$OUTLIER_OUTPUT_DIR"/SRR127388*/outliers.tsv; do
    contig_name=$(basename $(dirname "$outlier"))  # extract SRR ID
    bin_path="$BIN_DIR/$contig_name"  # corresponding bin directory
    
    # Make sure the bin directory exists for the sample
    if [[ -d "$bin_path" ]]; then
        echo "Filtering outliers for sample: $contig_name"
        refinem filter_bins -x fasta --modified_only "$bin_path" "$outlier" "$FILTERED_OUTPUT_DIR/$contig_name"
    else
        echo "No bin directory found for $contig_name"
    fi
done

