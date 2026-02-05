#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=4:00:00
#SBATCH --mem=8GB
#SBATCH --array=1-8
#SBATCH -o /hpcfs/users/a1871996/logs/%x_%j.out
#SBATCH -e /hpcfs/users/a1871996/logs/%x_%j.err
 
#set up email notifications
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=anqi.wang@adelaide.edu.au

# Load in modules
module load FastQC

# change to the fastq directory
cd /hpcfs/users/a1871996/20251027_mDegs2_KO/03_fastp

# set some variables 
OUTDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/04_trimmedqc" 
FIRSTREAD=$(ls ${SLURM_ARRAY_TASK_ID}_*1.trimmed.fastq.gz)
SECONDREAD=$(ls ${SLURM_ARRAY_TASK_ID}_*2.trimmed.fastq.gz)
# do fastQC 
fastqc -t 8 -f fastq -o ${OUTDIR} --nogroup ${FIRSTREAD} ${SECONDREAD}
