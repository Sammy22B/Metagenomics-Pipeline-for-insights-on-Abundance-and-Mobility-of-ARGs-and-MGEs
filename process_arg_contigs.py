#!/usr/bin/env python3

import pandas as pd
from Bio import SeqIO
import os

INPUT_DIR = "/home/sammy/hpc_quast/Megahit_Results"
OUTPUT_DIR = "/home/sammy/hpc_quast/ARG_CContigs"

samples = ['SRR12738813']

def parse_blastx_and_extract_sequences(sample):
    blastx_file = f"{OUTPUT_DIR}/{sample}_arg_hits.txt"
    input_fasta = f"{INPUT_DIR}/{sample}_Assembled.contigs.fa"
    output_fasta = f"{OUTPUT_DIR}/{sample}_arg_carrying_contigs.fa"

    df = pd.read_csv(blastx_file, sep='\t', header=None,
                     names=['qseqid', 'sseqid', 'pident', 'length', 'mismatch', 'gapopen',
                            'qstart', 'qend', 'sstart', 'send', 'evalue', 'bitscore', 'qcovs'])
    
    filtered_df = df[(df['evalue'] <= 1e-10) & 
                     (df['pident'] >= 80) & 
                     (df['qcovs'] >= 70)]
    
    arg_contigs = set(filtered_df['qseqid'].unique())

    # Extract sequences
    with open(output_fasta, 'w') as out_f:
        for record in SeqIO.parse(input_fasta, 'fasta'):
            if record.id in arg_contigs:
                SeqIO.write(record, out_f, 'fasta')
    
    print(f"Sample {sample}: {len(arg_contigs)} ARG-carrying contigs extracted")

# Process each sample
for sample in samples:
    parse_blastx_and_extract_sequences(sample)

print("Processing complete. ARG-carrying contig sequences have been extracted for all samples.")
