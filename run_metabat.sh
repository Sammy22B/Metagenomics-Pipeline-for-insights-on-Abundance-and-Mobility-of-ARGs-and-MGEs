#!/bin/bash
RESULTS_DIR=~/Megahit_Results
BAM_DIR=~/BAM_sorted_maps
OUT_DIR=~/metabat_binning_op
THREADS=38
SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for SRR in "${SRR_IDS[@]}"
do
CONTIGS_FILE="${RESULTS_DIR}/${SRR}_Assembled.contigs.fa"
BAM_FILE="${BAM_DIR}/${SRR}_mapped_sorted.bam"
DEPTH_FILE="${OUT_DIR}/${SRR}_depth.txt"
jgi_summarize_bam_contig_depths --outputDepth ${DEPTH_FILE} ${BAM_FILE}
METABAT_OUT="${OUT_DIR}/${SRR}/metabat2"
mkdir -p ${METABAT_OUT}
metabat2 -i ${CONTIGS_FILE} -a ${DEPTH_FILE} -o ${METABAT_OUT}/bins -t ${THREADS} -m 1500
echo "Binning completed for ${SRR}"
done
