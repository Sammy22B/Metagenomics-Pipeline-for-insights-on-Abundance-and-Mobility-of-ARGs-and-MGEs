#!/usr/bin/env python3
import os

# Corrected Directory paths
contigs_dir = '/data/sms/home/m5/sneha/ARG_CContigs'  # Correct path where your contigs.fa files are
hits_dir = '/data/sms/home/m5/sneha/ARG_CContigs'  # Update with your actual directory for hits
output_dir = '/data/sms/home/m5/sneha/Extracted_output'  # Directory where you want to store TSVs

# Make sure output directory exists
os.makedirs(output_dir, exist_ok=True)

# Function to extract contig IDs from sample_arg_carrying_contigs.fa
def get_contig_ids(contig_file):
    contig_ids = set()
    with open(contig_file, 'r') as f:
        for line in f:
            if line.startswith('>'):
                contig_id = line.strip().split()[0][1:]  # Extract contig ID, removing '>'
                contig_ids.add(contig_id)
    return contig_ids

# Function to filter the sample_arg_hits.txt based on contig IDs
def filter_hits(hits_file, contig_ids, output_file):
    with open(hits_file, 'r') as infile, open(output_file, 'w') as outfile:
        outfile.write(infile.readline().replace(',', '\t'))  # Write header and replace commas with tabs
        for line in infile:
            hit_contig_id = line.strip().split()[0]  # Assuming contig ID is the first column
            if hit_contig_id in contig_ids:
                outfile.write(line.replace(',', '\t'))  # Replace commas with tabs in each line

# Loop through each sample
samples = ['SRR12738806', 'SRR12738807', 'SRR12738811', 'SRR12738812', 'SRR12738813']  # Update with your actual sample names

for sample in samples:
    contig_file = f"{contigs_dir}/{sample}_arg_carrying_contigs.fa"
    hits_file = f"{hits_dir}/{sample}_arg_hits.txt"
    output_file = f"{output_dir}/{sample}_filtered_hits.tsv"  # Save output as .tsv
    
    # Check if contig file exists
    if os.path.exists(contig_file):
        # Extract contig IDs and filter hits
        contig_ids = get_contig_ids(contig_file)
        filter_hits(hits_file, contig_ids, output_file)
    else:
        print(f"Contig file {contig_file} not found!")

print("Filtered results have been saved as TSV files to the output directory.")

