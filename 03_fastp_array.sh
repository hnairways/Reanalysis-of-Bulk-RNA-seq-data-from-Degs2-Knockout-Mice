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
module load fastp

# change to the fastq directory
cd /hpcfs/users/a1871996/20251027_mDegs2_KO/01_rawdata
# set some variables
RAWDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/01_rawdata" 
OUTDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/03_fastp"
FIRSTREAD=`ls ${SLURM_ARRAY_TASK_ID}_*1.fastq.gz`
SECONDREAD=`ls ${SLURM_ARRAY_TASK_ID}_*2.fastq.gz`

#output filenames
BASE=$(basename ${FIRSTREAD} _1.fastq.gz)

# Run fastp
fastp \
  -i ${FIRSTREAD} \
  -I ${SECONDREAD} \
  -o ${OUTDIR}/${BASE}_1.trimmed.fastq.gz \
  -O ${OUTDIR}/${BASE}_2.trimmed.fastq.gz \
  -h ${OUTDIR}/${BASE}_fastp.html \
  -j ${OUTDIR}/${BASE}_fastp.json \
  -w 8