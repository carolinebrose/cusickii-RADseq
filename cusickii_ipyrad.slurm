#!/bin/bash

#SBATCH --job-name cusickii_ipyrad1
#SBATCH -A tanklab
#SBATCH -t 5-00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cbrose1@uwyo.edu
#SBATCH -e errors/cusickii_ipyrad1%A_%a.err
#SBATCH -o outs/cusickii_ipyrad1%A_%a.out

module load gcc/12.2.0 miniconda3/23.1.0

## run ipyrad, excluding steps
conda activate ipyrad
ipyrad -p ../params_files/params-cusickii.txt -s 1234567 -c 16 --f