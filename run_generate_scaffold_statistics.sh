#!/bin/bash

CONTIGS_DIR="/data/sms/home/m5/Megahit_Results"  # directory with contigs
BIN_DIR="/data/sms/home/m5/curated_BINS"  # directory with bins
STATS_OUTPUT_DIR="/data/sms/home/m5/scaffold_stats_output"  # output directory for stats
BAM_FILES_DIR="/data/sms/home/m5/BAM_sorted_maps"

# Create output directory if it does not exist
mkdir -p "$STATS_OUTPUT_DIR"

# Loop through each contig and corresponding bin
for contig in "$CONTIGS_DIR"/SRR127388*_Assembled.contigs.fa; do
    contig_name=$(basename "$contig" _Assembled.contigs.fa)  # extract SRR ID
    bin_path="$BIN_DIR/$contig_name"  # corresponding bin directory
    bam_files="$BAM_FILES_DIR/${contig_name}_mapped_sorted.bam"  # corresponding BAM files
    
    # Make sure the bin directory exists for the sample
    if [[ -d "$bin_path" ]]; then
        echo "Running scaffold_stats for sample: $contig_name"
        refinem scaffold_stats -c 16 --genome_ext fasta "$contig" "$bin_path" "$STATS_OUTPUT_DIR/$contig_name" "$bam_files"
    else
        echo "No bin directory found for $contig_name"
    fi
done

