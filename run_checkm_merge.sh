#!/bin/bash

BIN_DIR="/data/sms/home/m5/curated_BINS"   # Update to your path
OUTPUT_DIR="/data/sms/home/m5/checkm_merge_output"  # Directory for the merged results
MARKER_LIST="/data/sms/home/m5/Markers_list"
mkdir -p "$OUTPUT_DIR"

for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813; do 
    BIN_DIR_FILE="${BIN_DIR}/${sample}"
    MARKERS="${MARKER_LIST}/${sample}/marker_gene_stats.tsv"
    
    # Correcting the checkm merge command
    checkm merge --delta_comp 5.0 --delta_cont 10.0 --merged_comp 50.0 --merged_cont 20.0 -t 38 -x fasta "$MARKERS" "$BIN_DIR_FILE" "$OUTPUT_DIR/${sample}_merged"
done

echo "MERGING COMPLETE"

