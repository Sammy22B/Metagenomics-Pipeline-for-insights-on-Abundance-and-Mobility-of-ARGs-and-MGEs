#!/bin/bash

FINAL_FILTERED_DIR="/data/sms/home/m5/final_filtered_bins"
TAXON_PROFILE_OUTPUT_DIR="/data/sms/hpome/m5/taxon_profile_output"
SSU_DB="/data/sms/home/m5/Downloads/refinemDB/gtfn_r80_ssu_db"
REFERENCE_TAXONOMY="/path/to/reference_taxonomy"
SSU_OUTPUT_DIR="/data/sms/home/m5/ssu_output"

# Create output directory if it does not exist
mkdir -p "$SSU_OUTPUT_DIR"

# Loop through bins and check for SSU rRNA gene inconsistencies
for filtered_bin in "$FINAL_FILTERED_DIR"/SRR127388*; do
    contig_name=$(basename "$filtered_bin")  # extract SRR ID
    echo "Identifying SSU erroneous scaffolds for sample: $contig_name"
    refinem ssu_erroneous "$filtered_bin" "$TAXON_PROFILE_OUTPUT_DIR/$contig_name" "$SSU_DB" "$REFERENCE_TAXONOMY" "$SSU_OUTPUT_DIR/$contig_name"
done

