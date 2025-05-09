#!/usr/bin/env python3
from Bio import SeqIO

input_file = "SRR12738806_prodigal_orfs.fna"
output_file = "output.bed"

with open(output_file, 'w') as bed_file:
    for record in SeqIO.parse(input_file, "fasta"):
        seq_id = record.id
        length = len(record.seq)
        # Writing to BED: seq_id, start (0), end (length)
        bed_file.write(f"{seq_id}\t0\t{length}\n")

