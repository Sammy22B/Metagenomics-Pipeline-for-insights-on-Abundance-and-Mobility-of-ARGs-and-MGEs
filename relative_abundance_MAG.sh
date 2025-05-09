#!/bin/bash
BIN_DIR="/data/sms/home/m5/Nfinal_filtered_bins"      # Directory containing sample subdirectories with refined bins
READS_DIR="/data/sms/home/m5/OG_READS"               # Directory containing paired-end reads
OUT_DIR="/data/sms/home/m5/NRelative_op"         # Output directory for SAM, BAM, and coverage files
SAMPLES=("SRR12738806" "SRR12738807" "SRR12738811" "SRR12738812" "SRR12738813")  # Sample directories
mkdir -p "$OUT_DIR"
for SAMPLE in "${SAMPLES[@]}"; do
    echo "Processing $SAMPLE"

    SAMPLE_BIN_DIR="$BIN_DIR/$SAMPLE"               # Directory containing refined bins for the current sample
    SAMPLE_READS_1="$READS_DIR/${SAMPLE}_1.fastq"  # Forward paired-end reads
    SAMPLE_READS_2="$READS_DIR/${SAMPLE}_2.fastq"  # Reverse paired-end reads
    SAMPLE_OUT_DIR="$OUT_DIR/$SAMPLE"               # Output directory for the current sample
    mkdir -p "$SAMPLE_OUT_DIR"

    for BIN in "$SAMPLE_BIN_DIR"/*.fasta; do
        BIN_NAME=$(basename "$BIN" .fasta)  # Extract bin name without extension
        echo "Mapping reads to $BIN_NAME"

        bowtie2-build "$BIN" "$SAMPLE_OUT_DIR/${BIN_NAME}_index"
        bowtie2 -x "$SAMPLE_OUT_DIR/${BIN_NAME}_index" -1 "$SAMPLE_READS_1" -2 "$SAMPLE_READS_2" -S "$SAMPLE_OUT_DIR/${BIN_NAME}.sam" 2>refinedMAG.log
        samtools view -bS "$SAMPLE_OUT_DIR/${BIN_NAME}.sam" > "$SAMPLE_OUT_DIR/${BIN_NAME}.bam"
        samtools sort "$SAMPLE_OUT_DIR/${BIN_NAME}.bam" -o "$SAMPLE_OUT_DIR/${BIN_NAME}_sorted.bam"
        samtools index "$SAMPLE_OUT_DIR/${BIN_NAME}_sorted.bam"

        bedtools genomecov -ibam "$SAMPLE_OUT_DIR/${BIN_NAME}_sorted.bam" -g "$BIN" > "$SAMPLE_OUT_DIR/${BIN_NAME}_coverage.txt"

        TOTAL_READS=$(cat "$SAMPLE_READS_1" "$SAMPLE_READS_2" | echo $((`wc -l`/4)))
        COVERED_READS=$(awk '{sum+=$2} END {print sum}' "$SAMPLE_OUT_DIR/${BIN_NAME}_coverage.txt")
        REL_ABUNDANCE=$(echo "scale=6; $COVERED_READS / $TOTAL_READS" | bc)
        echo "Relative abundance of $BIN_NAME: $REL_ABUNDANCE" > "$SAMPLE_OUT_DIR/${BIN_NAME}_relative_abundance.txt"
    done

    echo "$SAMPLE processing completed."
done

echo "All samples processed."

