📘 Metagenomic Insights into the Abundance and Mobility of Antibiotic Resistance Genes and Associated Mobile Genetic Elements in Wheat Rhizosphere Samples Using a Bioinformatics Pipeline
🔍 Project Overview
This repository contains the complete bioinformatics pipeline and associated Linux scripts used in my master's dissertation project. The study focuses on identifying antibiotic resistance genes (ARGs) and mobile genetic elements (MGEs) in metagenomic samples from the wheat rhizosphere, assessing their abundance and potential mobility using a comprehensive metagenomics-based computational workflow.

🧪 Objectives
Identify and annotate ARGs from shotgun metagenomic sequences.

Detect and classify MGEs such as plasmids, integrative elements (ICEs/IMEs).

Investigate ARG mobility by checking for oriT, relaxase, T4CP, and T4SS elements.

Perform binning and MAG quality assessment.

Perform taxonomic classification and calculate relative abundance of MAGs.

🧭 Workflow Steps
Each script in this repository corresponds to a stage in the bioinformatics workflow, organized below in execution order:

1️⃣ Data Preprocessing
01_fastqc_trimming.sh: Run FastQC and trim adapters using Trimmomatic or fastp.

2️⃣ Assembly
02_megahit_assembly.sh: Assemble high-quality reads using MEGAHIT.

3️⃣ Contig Quality Check
03_quast.sh: Generate assembly statistics using QUAST.

4️⃣ Read Mapping
04_bowtie2_mapping.sh: Map quality reads back to assembled contigs.

5️⃣ ARG Identification
05_blastx_ARG_identification.sh: Identify ARGs by running BLASTX against the CARD/SARG database.

06_extract_ARG_contigs.py: Filter and extract contigs based on identity, coverage, and e-value thresholds.

6️⃣ ORF Prediction
07_prodigal_ORFs.sh: Predict open reading frames using Prodigal.

7️⃣ Plasmid Detection
08_plasflow.sh: Identify plasmid-origin contigs using PlasFlow.

8️⃣ ARG Mobility (oriT, relaxase, T4CP, T4SS)
09_oriTfinder_check.sh: Identify elements involved in plasmid mobility.

9️⃣ Mobile Genetic Elements
10_ICEfinder.sh: Detect integrative and conjugative/mobilizable elements (ICEs/IMEs).

🔟 Binning and Refinement
11_metabat2_maxbin2_concoct.sh: Generate genome bins using multiple binning tools.

12_checkm_quality.sh: Assess bin completeness and contamination using CheckM.

13_refinem.sh: Refine MAGs by removing contaminated or misclassified contigs.

🔢 MAG Abundance and Taxonomy
14_calculate_MAG_abundance.sh: Estimate the relative abundance of MAGs.

15_gtdbtk_taxonomy.sh: Assign taxonomy using GTDB-Tk.

🧬 Annotation and BLASTP
16_blastp_NR_annotation.sh: Annotate predicted proteins using BLASTP against the NR database.

⚙️ Requirements & Dependencies
Linux (Ubuntu recommended)

Conda or manual installations for tools:

FastQC

Trimmomatic / fastp

MEGAHIT

QUAST

Bowtie2

SAMtools

Prodigal

BLAST+

PlasFlow

oriTfinder

ICEfinder

MetaBAT2, MaxBin2, CONCOCT

CheckM, RefineM

GTDB-Tk

VAMB (optional)

Python 3 (for custom scripts)

