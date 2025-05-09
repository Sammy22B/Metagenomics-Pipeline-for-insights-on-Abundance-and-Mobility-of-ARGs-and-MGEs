#!/bin/bash

INPUT_DIR="/data/sms/home/m5/sneha/ARG_CContigs"
OUTPUT_DIR="/data/sms/home/m5/GTDBTk_Classification_output"

mkdir -p "$OUTPUT_DIR"

for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813
do
    output_dir="${OUTPUT_DIR}/${sample}_gtdbtk_output"

    # Run GTDB-Tk classify on the ARG-carrying contigs
    gtdbtk classify_wf --genome_dir "$INPUT_DIR" --out_dir "$output_dir" --cpus 38 --extension fa --force 

    echo "GTDB-Tk classification completed for $sample"
done

echo "GTDB-Tk taxonomic classification complete."
