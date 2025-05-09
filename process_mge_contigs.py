#!/usr/bin/env python3

import os
from Bio import SeqIO

blastp_results_folder = "/data/sms/home/m5/newBLASTP_Annotations"
accs_folder = "/data/sms/home/m5/Megahit_Results"

evalue_threshold = 10**-5
query_coverage_threshold = 70.0
samples = ["SRR12738806", "SRR12738807", "SRR12738811", "SRR12738812", "SRR12738813"]

def filter_blastp_results(blastp_file):
    filtered_hits = set()
    with open(blastp_file, 'r') as f:
        for line in f:
            parts = line.strip().split("\t")
            query_id = parts[0]
            evalue = float(parts[10])
            qcov = float(parts[12])
            # Check if the hit meets the filtering criteria
            if evalue <= evalue_threshold and qcov >= query_coverage_threshold:
                filtered_hits.add(query_id)
    return filtered_hits

def extract_sequences(fasta_file, filtered_hits, output_file):
    with open(output_file, 'w') as out_f:
        for record in SeqIO.parse(fasta_file, 'fasta'):
            if record.id in filtered_hits:
                SeqIO.write(record, out_f, 'fasta')

for sample in samples:   
    blastp_file = os.path.join(blastp_results_folder, f"{sample}_blastp_results.txt")
    accs_file = os.path.join(accs_folder, f"{sample}_Assembled.contigs.fa")
    output_file = os.path.join(accs_folder, f"{sample}_filteredHit_sequences.fa")

    print(f"Processing sample {sample}...")

    filtered_hits = filter_blastp_results(blastp_file)
    extract_sequences(accs_file, filtered_hits, output_file)

    print(f"Filtered sequences for {sample} written to {output_file}.")

