#!/bin/bash
SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for sample in "${SRR_IDS[@]}"
do
 checkm lineage_wf -t 38 -x fasta og_maxbin_binning_op/"$sample"/maxbin2 checkm_og_maxb_op_"$sample"
done

SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for sample in "${SRR_IDS[@]}"
do
 checkm qa checkm_og_maxb_op_"$sample"/lineage.ms checkm_og_maxb_op_"$sample" -o 2 -f checkm_og_maxb_results_"$sample".tsv --tab_table
done

SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
head -n 1 checkm_og_maxb_results_SRR12738806.tsv > combined_checkm_og_maxb_results.tsv
for sample in "${SRR_IDS[@]}"
do
 tail -n +2 checkm_og_maxb_results_"$sample".tsv >> combined_checkm_og_maxb_results.tsv
done
