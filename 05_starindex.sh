#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=1:00:00
#SBATCH --mem=100GB
#SBATCH -o /hpcfs/users/a1871996/logs/%x_%j.out
#SBATCH -e /hpcfs/users/a1871996/logs/%x_%j.err
 
#set up email notifications
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=anqi.wang@adelaide.edu.au

# Load in modules
module load STAR

# Set some directory
cd /hpcfs/users/a1871996/
FA="refs/Mus_musculus.GRCm39.dna.primary_assembly.fa"
GTF="refs/Mus_musculus.GRCm39.115.gtf"
OUTDIR="/hpcfs/users/a1871996/20251027_mDegs2_KO/05_starindex/"


STAR \
--runThreadN 16 \
--runMode genomeGenerate \
--genomeDir ${OUTDIR} \
--genomeFastaFiles ${FA} \
--sjdbGTFfile ${GTF} \
--sjdbOverhang 149