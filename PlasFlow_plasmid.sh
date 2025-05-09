#!/bin/bash

INPUT_DIR="/data/sms/home/m5/sneha/ARG_CContigs"
OUTPUT_DIR="/data/sms/home/m5/PlasFlow_Output"

mkdir -p "$OUTPUT_DIR"

for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813
do
    input_file="${INPUT_DIR}/${sample}_arg_carrying_contigs.fa"
    output_file="${OUTPUT_DIR}/${sample}_plasflow_output.tsv"

    # Run PlasFlow on the ARG-carrying contigs
    plasflow.py --input "$input_file" --output "$output_file" --threshold 0.7

    echo "PlasFlow completed for $sample"
done

echo "Plasmid detection complete."

