#!/usr/bin/env pyhton3
from Bio import SeqIO
import os

# Paths and samples
samples = ["SRR12738806", "SRR12738807", "SRR12738811", "SRR12738812", "SRR12738813"]
refined_bin_dir = "/data/sms/home/m5/final_filtered_bins"
arg_output_dir = "/data/sms/home/m5/new_arg_identification"
extracted_seqs_dir = "/data/sms/home/m5/extracted_arg_sequences"

# Make sure output directory exists
os.makedirs(extracted_seqs_dir, exist_ok=True)

for sample in samples:
    print(f"Extracting ARG sequences for sample {sample}...")

    sample_dir = os.path.join(refined_bin_dir, sample)
    for fasta_file in os.listdir(sample_dir):
        if fasta_file.endswith(".fasta"):
            bin_name = os.path.splitext(fasta_file)[0]
            bin_fasta = os.path.join(sample_dir, fasta_file)
            filtered_hits_file = os.path.join(arg_output_dir, f"{bin_name}_arg_filtered_hits.txt")
            extracted_seqs_output = os.path.join(extracted_seqs_dir, f"{bin_name}_arg_sequences.fa")

            # Check if filtered hits file exists
            if os.path.isfile(filtered_hits_file):
                # Read the sequence IDs from the filtered BLAST hits file
                with open(filtered_hits_file) as f:
                    filtered_ids = {line.split()[0] for line in f}

                # Extract sequences from the FASTA file
                with open(extracted_seqs_output, 'w') as out_fasta:
                    for record in SeqIO.parse(bin_fasta, "fasta"):
                        if record.id in filtered_ids:
                            SeqIO.write(record, out_fasta, "fasta")

                print(f"Extracted sequences for {bin_name}.")
            else:
                print(f"No filtered ARG hits found for {bin_name}, skipping.")

print("Sequence extraction completed for all samples.")

