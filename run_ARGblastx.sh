#!/bin/bash

INPUT_DIR="/home/sammy/hpc_quast/Megahit_Results"

OUTPUT_DIR="/home/sammy/hpc_quast/ARG_CContigs"

DB_PATH="/home/sammy/card_db"

mkdir -p "$OUTPUT_DIR"

for sample in SRR12738813
do
    input_file="${INPUT_DIR}/${sample}_Assembled.contigs.fa"
    output_file="${OUTPUT_DIR}/${sample}_arg_hits.txt"

    blastx -query "$input_file" \
           -db "$DB_PATH" \
           -out "$output_file" \
           -evalue 1e-10 \
           -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
           -num_threads 8
echo "BLASTX conmpleted for $sample"

done


echo "BLASTX analysis complete."
