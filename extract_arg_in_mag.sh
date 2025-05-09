#!/bin/bash

SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
REFINED_BIN_DIR="/data/sms/home/m5/final_filtered_bins"
ARG_OUTPUT_DIR="/data/sms/home/m5/new_arg_identification"
EXTRACTED_SEQS_DIR="/data/sms/home/m5/extracted_argMAG_sequences"

mkdir -p "$EXTRACTED_SEQS_DIR"

for sample in "${SAMPLES[@]}"; do
    echo "Extracting ARG sequences for sample $sample..."

    for sample_bin in ${REFINED_BIN_DIR}/${sample}/*.fasta; do
        bin_name=$(basename "$sample_bin" .fasta)
        filtered_hits="${ARG_OUTPUT_DIR}/${bin_name}_arg_filtered_hits.txt"
        extracted_seqs_output="${EXTRACTED_SEQS_DIR}/${bin_name}_arg_sequences.fa"

        # Ensure the filtered hits file exists before processing
        if [ -f "$filtered_hits" ]; then
            # Extract the sequence IDs from the filtered hits
            awk '{print $1}' "$filtered_hits" | sort | uniq > "${EXTRACTED_SEQS_DIR}/${bin_name}_arg_ids.txt"

            # Use bioawk to extract sequences
            bioawk -c fastx 'NR==FNR{ids[$1];next}($1 in ids){print ">"$1"\n"$2}' "${EXTRACTED_SEQS_DIR}/${bin_name}_arg_ids.txt" "$sample_bin" > "$extracted_seqs_output"

            echo "Extracted sequences for $bin_name."
        else
            echo "No filtered ARG hits found for $bin_name, skipping."
        fi
    done
done

echo "Sequence extraction completed for all samples."

