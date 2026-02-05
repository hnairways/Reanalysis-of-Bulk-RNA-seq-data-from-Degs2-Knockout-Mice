#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=5:00:00
#SBATCH --mem=50GB
#SBATCH --array=1-8
#SBATCH -o /hpcfs/users/a1871996/logs/%x_%j.out
#SBATCH -e /hpcfs/users/a1871996/logs/%x_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=anqi.wang@adelaide.edu.au

# Load STAR
module load STAR

# Set up some dir
cd /hpcfs/users/a1871996/20251027_mDegs2_KO/03_fastp

GENOMEDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/05_starindex"

R1=$(ls ${SLURM_ARRAY_TASK_ID}_*1.trimmed.fastq.gz)
R2=$(ls ${SLURM_ARRAY_TASK_ID}_*2.trimmed.fastq.gz)

BAMDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/06_align/bam"
LOGDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/06_align/log"

SAMPLE=$(basename "${R1}")
PREFIX="${BAMDIR}/${SAMPLE}."

# set output
mkdir -p "${BAMDIR}" "${LOGDIR}"

# STAR
STAR \
  --genomeDir "${GENOMEDIR}" \
  --runThreadN 16 \
  --readFilesIn "${R1}" "${R2}" \
  --readFilesCommand "gunzip -c" \
  --outSAMtype BAM SortedByCoordinate \
  --outFileNamePrefix "${PREFIX}"

# logs
mv "${PREFIX}"*out "${LOGDIR}/"
mv "${PREFIX}"*tab "${LOGDIR}/"
