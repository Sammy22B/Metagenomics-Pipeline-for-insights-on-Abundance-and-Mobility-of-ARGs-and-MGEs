#!/bin/bash

INPUT_DIR="/data/sms/home/m5/sneha/ARG_CContigs"
OUTPUT_DIR="/data/sms/home/m5/newBLASTP_Annotations"
DB_PATH="/data/sms/home/m5/Downloads/nr/nr_db"

mkdir -p "$OUTPUT_DIR"

for sample in SRR12738806 SRR12738807 SRR12738811 SRR12738812 SRR12738813
do
    input_file="${INPUT_DIR}/${sample}_arg_carrying_contigs.fa"
    output_file="${OUTPUT_DIR}/${sample}_blastp_results.txt"

    # Run BLASTP for functional annotation
    blastp -query "$input_file" -db "$DB_PATH" -out "$output_file" -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" -num_threads 38

    echo "BLASTP completed for $sample"
done

echo "BLASTP functional annotation complete."
 
