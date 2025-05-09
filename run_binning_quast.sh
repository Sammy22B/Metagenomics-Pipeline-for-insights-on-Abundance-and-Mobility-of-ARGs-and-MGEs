#!/bin/bash
SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for sample in "${SRR_IDS[@]}"
do
quast.py maxbin_binning_op/$sample/maxbin2/*.fasta -o quast_op_$sample
echo "quast completed for $sample"
done

