#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=1:00:00
#SBATCH --mem=16GB
#SBATCH -o /hpcfs/users/a1871996/logs/%x_%j.out.txt
#SBATCH -e /hpcfs/users/a1871996/logs/%x_%j.err.txt
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=anqi.wang@adelaide.edu.au

# Load samtools
module load Subread/2.0.6-GCC-11.2.0
# Set up some dir
cd /hpcfs/users/a1871996/20251027_mDegs2_KO/06_align/bam

GTF="/hpcfs/users/a1871996/refs/Mus_musculus.GRCm39.115.gtf"

mkdir -p /hpcfs/users/a1871996/20251027_mDegs2_KO/09_featurecounts_q5
#BAM=ls ${SLURM_ARRAY_TASK_ID}_*.trimmed.fastq.gz.Aligned.sortedByCoord.out.bam)
OUTDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/09_featurecounts_q5/counts.out"

# samtools
# Settings for featureCounts. 
# To set this to count strictly exonic reads, I change fracOverlap to be the value 1. 
# The value minOverlap may also need adjusting based on your own read lengths. 
# the -Q option is set to 10, meaining a mapping quality of at least 10. 
# the -p flad indicates the input bam files were generated from paired end data

featureCounts \
  -T 16 \
  -p \
  -Q 5 \
  --verbose \
  -a "${GTF}" \
  -o "${OUTDIR}"\
  *.bam