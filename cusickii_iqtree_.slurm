#!/bin/bash

#SBATCH --job-name lociIQT   # give the job a name
#SBATCH -A tanklab    # specify the account
#SBATCH -t 4-24:00		 # how much time?
#SBATCH --nodes=1			# how many nodes?
#SBATCH --cpus-per-task=32	# 2 cores
#SBATCH --mem=36G			# 50 GB memory
#SBATCH --mail-type=ALL		# Send emails on start, fail, completion
#SBATCH --mail-user=cbrose1@uwyo.edu   # specify your email
#SBATCH -e err_lociIQT%A.err		# name error files and include job ID (%A)
#SBATCH -o std_lociIQT%A.out		# name standard out files and include job ID (%A)

module load gcc/12.2.0
module load arcc/1.0
module load python/3.10.6 
module load miniconda3
module load iq-tree

cd /pfs/tc1/project/tanklab/cbrose1/cusickii/IQTree

iqtree2 -s cusickii_rmFailed.nex -m MFP -T auto --prefix loci.IQT_ -B 1000 -nt AUTO -ntmax 32
