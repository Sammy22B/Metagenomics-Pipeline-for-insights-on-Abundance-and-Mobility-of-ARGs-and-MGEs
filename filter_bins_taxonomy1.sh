#!/bin/bash

TAXON_PROFILE_OUTPUT_DIR="/data/sms/home/m5/taxon_profile_output"
TAXON_FILTER_OUTPUT="taxon_filter.tsv"

# Loop through each bin's taxonomic profile and filter based on taxonomy
for taxon_profile in "$TAXON_PROFILE_OUTPUT_DIR"/SRR127388*; do
    contig_name=$(basename "$taxon_profile")  # extract SRR ID
    echo "Filtering taxonomic inconsistencies for sample: $contig_name"
    refinem taxon_filter --trusted_scaffold 50.0 --consensus_taxon 50.0 -c 40 "$taxon_profile" "$TAXON_FILTER_OUTPUT"
done

