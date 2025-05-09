#!/usr/bin/env python3

import os
from Bio import SeqIO

# Directories and parameters
blastp_results_folder = "/data/sms/home/m5/newBLASTP_Annotations"
accs_folder = "/data/sms/home/m5/sneha/ARG_CContigs"

evalue_threshold = 10**-5
query_coverage_threshold = 70.0
samples = ["SRR12738806", "SRR12738807", "SRR12738811", "SRR12738812", "SRR12738813"]

# Function to filter BLASTP results based on thresholds
def filter_blastp_results(blastp_file):
    filtered_hits = set()
    with open(blastp_file, 'r') as f:
        for line in f:
            parts = line.strip().split("\t")
            if len(parts) < 13:  # Check if line has the expected number of columns
                print(f"Skipping malformed line: {line}")
                continue
            query_id = parts[0]           
            evalue = float(parts[10])
            qcov = float(parts[12])
            
            # Print debug information for each parsed value
            print(f"Query ID: {query_id}, E-value: {evalue}, Query Coverage: {qcov}")

            # Check if the hit meets the filtering criteria
            if evalue <= evalue_threshold and qcov >= query_coverage_threshold:
                print(f"Adding {query_id} to filtered hits.")
                filtered_hits.add(query_id)
    
    return filtered_hits

# Function to extract sequences from FASTA file based on filtered hits
def extract_sequences(accs_file, filtered_hits, output_file):
    with open(output_file, 'w') as out_f:
        for record in SeqIO.parse(accs_file, 'fa'):
            if record.id in filtered_hits:
                print(f"Writing sequence {record.id} to output.")
                SeqIO.write(record, out_f, 'fa')

# Iterate through each sample, process BLASTP results, and extract sequences
for sample in samples:   
    blastp_file = os.path.join(blastp_results_folder, f"{sample}_blastp_results.txt")
    accs_file = os.path.join(accs_folder, f"{sample}_arg_carrying_contigs.fa")
    output_file = os.path.join(accs_folder, f"{sample}_filteredHit_sequences.fa")

    print(f"Processing sample {sample}...")

    filtered_hits = filter_blastp_results(blastp_file)
    if filtered_hits:
        extract_sequences(accs_file, filtered_hits, output_file)
    else:
        print(f"No filtered hits for {sample}.")

    print(f"Filtered sequences for {sample} written to {output_file}.")

