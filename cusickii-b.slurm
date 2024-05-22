#!/bin/bash

#SBATCH --job-name cusickii_filt_awk-b
#SBATCH -A tanklab
#SBATCH -t 5-00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cbrose1@uwyo.edu
#SBATCH -e cusickii_filt_awk-branch%A_%a.err
#SBATCH -o cusickii_filt_awk-branch%A_%a.out

module load gcc/12.2.0 miniconda3/23.1.0

## run ipyrad, excluding steps
conda activate ipyrad
ipyrad -p ../params_files/params-cusickii.txt -b cusickii_rmFailed ../namesFiles/names_cusickii_trim.txt --f