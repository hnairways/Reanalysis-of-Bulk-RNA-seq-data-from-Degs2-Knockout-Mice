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

# Load samtools
module load SAMtools
# Set up some dir
cd /hpcfs/users/a1871996/20251027_mDegs2_KO/06_align/bam

BAM=$(ls ${SLURM_ARRAY_TASK_ID}_*.trimmed.fastq.gz.Aligned.sortedByCoord.out.bam)
OUTDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/08_samindex"

# samtools
samtools index -@ 16 "${BAM}" "${OUTDIR}/$(basename ${BAM}).bai"