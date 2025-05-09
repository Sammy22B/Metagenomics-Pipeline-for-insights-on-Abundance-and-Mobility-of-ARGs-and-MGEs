#!/bin/bash

SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")  # List of sample IDs
REFINED_BIN_DIR="/data/sms/home/m5/final_filtered_bins"   # Path to your refined bins directory
ARG_OUTPUT_DIR="/data/sms/home/m5/new_arg_identification"     # Path to output directory for ARG results
CARD_DB="/data/sms/home/m5/Downloads/card_data/new_card_db"                       # Path to CARD database
NUM_THREADS=60                                   # Adjust based on system resources

mkdir -p "$ARG_OUTPUT_DIR"
for sample in "${SAMPLES[@]}"; do
    echo "Processing ARG identification for sample $sample..."
    
    for sample_bin in ${REFINED_BIN_DIR}/${sample}/*.fasta; do
        bin_name=$(basename "$sample_bin" .fasta)
        output_file="${ARG_OUTPUT_DIR}/${SAMPLE}/${bin_name}_arg_hits.txt"

        echo "Running BLASTX for ARG identification on $sample_bin..."

        blastx -query "$sample_bin" \
               -db "$CARD_DB" \
               -evalue 1e-10 \
               -out "$output_file" \
               -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
               -num_threads $NUM_THREADS

        # Filter based on similarity >= 80% and query coverage >= 70%
        awk '$13 >= 70 {print $0}' "$output_file" > "${ARG_OUTPUT_DIR}/${bin_name}_arg_filtered_hits.txt"

        echo "BLASTX for ARG identification completed for $bin_name."
    done
done

echo "All ARG identification completed for all samples."

