#!/bin/bash
RESULTS_DIR=~/Megahit_Results
OUT_DIR=~/og_maxbin_binning_op
THREADS=38
DEPTH_DIR=~/Depth_Files
SRR_IDS=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")
for SRR in "${SRR_IDS[@]}"
do
CONTIGS_FILE="${RESULTS_DIR}/${SRR}_Assembled.contigs.fa"
DEPTH_FILE="${DEPTH_DIR}/${SRR}_depth.txt"
MAXBIN_OUT="${OUT_DIR}/${SRR}/maxbin2"
mkdir -p ${MAXBIN_OUT}
run_MaxBin.pl -min_contig_length 500 -contig ${CONTIGS_FILE} -out ${MAXBIN_OUT}/bins -abund ${DEPTH_FILE} -thread ${THREADS}
echo "Binning completed for ${SRR}"
done

