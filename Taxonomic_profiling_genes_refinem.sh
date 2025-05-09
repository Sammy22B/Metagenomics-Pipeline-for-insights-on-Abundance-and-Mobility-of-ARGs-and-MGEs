#!/bin/bash

GENE_OUTPUT_DIR="/data/sms/home/m5/gene_output"
STATS_OUTPUT_DIR="/data/sms/home/m5/scaffold_stats_output"
REFERENCE_DB="/data/sms/home/m5/Downloads/refinemDB/gtdb_r80_prot_db.dmnd" 
REFERENCE_TAXONOMY="/data/sms/home/m5/Downloads/refinemDB/gtdb_r80_taxonomy.2017-12-15.tsv"
TAXON_PROFILE_OUTPUT_DIR="/data/sms/home/m5/taxon_profile_output"

# Create output directory if it does not exist
mkdir -p "$TAXON_PROFILE_OUTPUT_DIR"

# Loop through each bin's gene output and run taxon profile
for gene_output in "$GENE_OUTPUT_DIR"/SRR127388*; do
    contig_name=$(basename "$gene_output")  # extract SRR ID
    scaffold_stats="$STATS_OUTPUT_DIR/$contig_name/scaffold_stats.tsv"  # corresponding scaffold stats
    
    echo "Running taxon profile for sample: $contig_name"
    refinem taxon_profile -e 0.001 -i 30.0 -c 40 -x faa "$gene_output" "$scaffold_stats" "$REFERENCE_DB" "$REFERENCE_TAXONOMY" "$TAXON_PROFILE_OUTPUT_DIR/$contig_name"
done

