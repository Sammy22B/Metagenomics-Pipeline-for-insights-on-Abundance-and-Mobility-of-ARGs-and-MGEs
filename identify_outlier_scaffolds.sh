#!/bin/bash

STATS_OUTPUT_DIR="/data/sms/home/m5/scaffold_stats_output"
OUTLIER_OUTPUT_DIR="/data/sms/home/m5/outlier_output"

# Create output directory if it does not exist
mkdir -p "$OUTLIER_OUTPUT_DIR"

# Loop through each sample's scaffold stats
for stats in "$STATS_OUTPUT_DIR"/SRR12738806/scaffold_stats.tsv; do
    contig_name=$(basename $(dirname "$stats"))  # extract SRR ID
    echo "Identifying outliers for sample: $contig_name"
    refinem outliers -r any --individual_plots "$stats" "$OUTLIER_OUTPUT_DIR/$contig_name"
done

