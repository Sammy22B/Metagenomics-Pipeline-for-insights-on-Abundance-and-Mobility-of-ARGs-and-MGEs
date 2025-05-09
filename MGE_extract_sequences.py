#!/usr/bin/env python3
from Bio import SeqIO
import os

# Define paths
input_fasta_dir = "/data/sms/home/m5/sneha/ARG_CContigs"  # Path to the original fasta files of ARG-carrying contigs
blastp_results_dir = "/data/sms/home/m5/BLASTP_Annotations"  # Path to the BLASTP results
output_fasta_dir = "/data/sms/home/m5/extracted_MGE_sequences"  # Path where extracted sequences will be saved

# Create output directory if it doesn't exist
os.makedirs(output_fasta_dir, exist_ok=True)

# List of samples
samples = ["SRR12738806", "SRR12738807", "SRR12738811", "SRR12738812", "SRR12738813"]

# Function to extract sequences
def extract_sequences(sample, input_fasta_file, blastp_result_file, output_fasta_file):
    # Read the BLASTP result file and get the sequence IDs
    mge_ids = set()
    with open(blastp_result_file) as f:
        for line in f:
            seq_id = line.split()[0]  # The first column is the query sequence ID
            mge_ids.add(seq_id)

    # Open the input FASTA file and output file
    with open(output_fasta_file, 'w') as output_handle:
        for record in SeqIO.parse(input_fasta_file, "fasta"):
            if record.id in mge_ids:
                SeqIO.write(record, output_handle, "fasta")

# Loop over samples and extract the sequences
for sample in samples:
    print(f"Extracting MGE sequences for sample {sample}...")
    
    input_fasta_file = os.path.join(input_fasta_dir, f"{sample}_arg_carrying_contigs.fa")
    blastp_result_file = os.path.join(blastp_results_dir, f"{sample}_blastp_results.txt")
    output_fasta_file = os.path.join(output_fasta_dir, f"{sample}_MGE_sequences.fa")
    
    # Extract sequences
    extract_sequences(sample, input_fasta_file, blastp_result_file, output_fasta_file)
    
    print(f"Extraction completed for {sample}.")

print("MGE sequence extraction completed for all samples.")

