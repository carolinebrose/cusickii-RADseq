#!/bin/bash

#SBATCH --job-name TrimAdapters
#SBATCH -A tanklab
#SBATCH -t 0-24:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24   
#SBATCH --mem=36G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cbrose1@uwyo.edu
#SBATCH -e errors/err_trimad_all_%A_%a.err
#SBATCH -o outs/std_trimad_all_%A_%a.out
#SBATCH --array=1-40

#make sure cpus match threads

# Try out trimming using adapters.fa from bbduk

#Load modules
module --ignore_cache load trimmomatic/0.39 gcc

#Set working directory
cd /project/tanklab/cbrose1/cusickii/demultiplexedFiles

#Array
for x in *.fq.gz
do
	allfastq=(${allfastq[@]} "${x}")
done

#Call directory, -1 will let you use array number due to count starting at 0
SAMPLE=${allfastq[($SLURM_ARRAY_TASK_ID-1)]}

#Lable reads 
ADAPTERS=../../'Illumina-adapters.fa' # Set this to the right path


# set up output directory
OUT_DIR=/project/tanklab/cbrose1/cusickii/ipyrad/trimmedFastqs # set to where you want this


#script for trimmed reads
trimmomatic SE -threads 24 $SAMPLE \
    $OUT_DIR/trimmed-$SAMPLE\
    ILLUMINACLIP:$ADAPTERS:2:30:10:8:true\
    LEADING:10 TRAILING:10\
    SLIDINGWINDOW:4:20 MINLEN:36
