#!/bin/bash
SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for sample in "${SRR_IDS[@]}"
do
 checkm lineage_wf -t 38 -x fasta final_filtered_bins/"$sample" checkm_bins_op_"$sample"
done

SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for sample in "${SRR_IDS[@]}"
do
 checkm qa checkm_bins_op_"$sample"/lineage.ms checkm_bins_op_"$sample" -o 2 -f checkm_bins_results_"$sample".tsv --tab_table
done

SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
head -n 1 checkm_bins_results_SRR12738806.tsv > combined_checkm_bins_results.tsv
for sample in "${SRR_IDS[@]}"
do
 tail -n +2 checkm_bins_results_"$sample".tsv >> combined_checkm_bins_results.tsv
done
