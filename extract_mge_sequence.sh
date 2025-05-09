#!/bin/bash

# Directories and files
INPUT_DIR="/data/sms/home/m5/BLASTP_Annotations"
OUTPUT_DIR="/data/sms/home/m5/Filtered_BLASTP"
ARG_CONTIGS_DIR="/data/sms/home/m5/sneha/ARG_CContigs"

# Filtering criteria
EVALUE_THRESHOLD="1e-5"
COVERAGE_THRESHOLD=70

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through each sample
for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813
do
    input_file="${INPUT_DIR}/${sample}_blastp_results.txt"
    output_file="${OUTPUT_DIR}/${sample}_filtered_results.txt"
    contig_file="${ARG_CONTIGS_DIR}/${sample}_arg_carrying_contigs.fa"

    # Parse and filter BLASTP results
    awk -v evalue="$EVALUE_THRESHOLD" -v coverage="$COVERAGE_THRESHOLD" \
    'BEGIN {OFS="\t"} {if ($11 <= evalue && ($7 - $6 + 1) / $13 * 100 >= coverage) print $1, $2, $3, $11}' \
    "$input_file" > "$output_file"

    echo "Filtered BLASTP results for $sample written to $output_file"

    # Extract sequences of filtered contigs
    grep -Ff <(cut -f1 "$output_file") "$contig_file" -A 1 > "${OUTPUT_DIR}/${sample}_filtered_contigs.fa"

    echo "Extracted sequences for $sample written to ${OUTPUT_DIR}/${sample}_filtered_contigs.fa"
done

echo "Filtering and sequence extraction completed for all samples."

