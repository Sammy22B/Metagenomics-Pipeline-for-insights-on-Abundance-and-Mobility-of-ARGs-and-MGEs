#!/bin/bash

INPUT_DIR="/data/sms/home/m5/sneha/ARG_CContigs"
OUTPUT_DIR="/data/sms/home/m5/Prodigal_ORFs"

mkdir -p "$OUTPUT_DIR"

for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813
do
    input_file="${INPUT_DIR}/${sample}_arg_carrying_contigs.fa"
    output_gbk="${OUTPUT_DIR}/${sample}_prodigal_orfs.gbk"
    output_faa="${OUTPUT_DIR}/${sample}_prodigal_orfs.faa"
    output_fna="${OUTPUT_DIR}/${sample}_prodigal_orfs.fna"

    # Run Prodigal to identify ORFs
    prodigal -i "$input_file" \
             -o "$output_gbk" \
             -a "$output_faa" \
             -d "$output_fna" \
             -p meta

    echo "Prodigal ORF identification completed for $sample"
done

echo "Prodigal ORF identification complete."

